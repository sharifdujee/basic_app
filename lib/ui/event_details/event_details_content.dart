import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:local_event_app/model/event.dart';
import 'package:local_event_app/style_guide.dart';
import 'package:provider/provider.dart';
import 'package:local_event_app/model/guest.dart';

class EventDetailsContent extends StatelessWidget {
  const EventDetailsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final event = Provider.of<Event>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 100,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.24),
            child: Text(
              event.title ?? '',
              style: eventWhiteTitleTextStyle,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.24),
              child: FittedBox(
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 18,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      event.location ?? '',
                      style: eventLocationTextStyle.copyWith(
                           fontWeight: FontWeight.w700),
                    )
                  ],
                ),


              )),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.24),
              child: FittedBox(
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_month_outlined,
                      size: 18,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      event.date != null
                          ? DateFormat('MM-dd-yyyy').format(event.date!)
                          : 'Date not available',
                      style: eventLocationTextStyle.copyWith(fontWeight: FontWeight.w700),
                    )

                  ],
                ),



              )),
          const SizedBox(
            height: 10,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.24),
              child: FittedBox(
                child: Row(
                  children: [
                    const Icon(
                      Icons.update,
                      size: 18,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      _dayLeft(event),
                      style: eventLocationTextStyle.copyWith(fontWeight: FontWeight.w700),
                    )

                  ],
                ),



              )),
          const SizedBox(
            height: 10,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.24),
              child: FittedBox(
                child: Row(
                  children: [
                    const Icon(
                      Icons.person,
                      size: 18,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      event.numberOfParticipant.toString(),
                      style: eventLocationTextStyle.copyWith(fontWeight: FontWeight.w700),
                    )

                  ],
                ),



              )),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              'Guest',
              style: guestTextStyle,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final guest in Guest.guest)
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: ClipOval(
                      child: Image.asset(
                        guest.imagePath ?? '',
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: event.punchline1, style: punchLine1TextStyle),
                  TextSpan(text: event.punchline2, style: punchLine2TextStyle),
                ],
              ),
            ),
          ),
          if( event.description!=null && event.description!.isNotEmpty) Padding(padding: const EdgeInsets.all(10),
          child: Text(event.description??'', style: eventLocationTextStyle.copyWith(color: Colors.black),),),
          if( event.galleryImages!.isNotEmpty) Padding(padding: const EdgeInsets.only(left: 16.0, bottom: 16.0, top: 160),
          child: Text('Gallery', style: guestTextStyle,),),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final galleryImagePath in event.galleryImages!)
                  Container(
                    margin: const EdgeInsets.only(left: 16.0, right: 16, bottom: 32),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: Image.asset(
                        galleryImagePath,
                        width: 180,
                        height: 180,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _dayLeft(Event event) {
    if (event.date != null) {
      final today = DateTime.now();
      final difference = event.date!.difference(today).inDays;

      if (difference > 0) {
        return '$difference days left Start the event.';
      } else if (difference == 0) {
        return 'The event is today!';
      } else {
        return 'The event has already passed.';
      }
    } else {
      return 'Event date is not available.';
    }
  }


}
