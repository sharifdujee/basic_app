import 'package:flutter/material.dart';
import 'package:local_event_app/model/event.dart';
import 'package:local_event_app/style_guide.dart';

class EventWidget extends StatelessWidget {
  const EventWidget({super.key, required this.event});
  final Event  event;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 20),
      elevation: 4,
      color: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24))
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(30),
              ),
              child: Image.asset(event.imagePath??'assets/images/guest.jpg', height: 150,fit: BoxFit.fitWidth,),

            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 8),
              child: Row(
                children: [
                  Expanded(flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(event.title??'', style: eventTitleTextStyle,),
                      const SizedBox(height: 10,),
                      FittedBox(
                        child: Row(
                          children: [
                            const Icon(Icons.location_on),
                            const SizedBox(width: 5,),
                           Text(event.location??'',
                             textAlign: TextAlign.right,
                             style: eventLocationTextStyle.copyWith(
                               color: Colors.black
                             ),)
                          ],
                        ),
                      )


                    ],
                  ),),
                  Expanded(flex: 1,
                  child: Text(event.duration!.toUpperCase(),
                    textAlign: TextAlign.right,
                    style: eventLocationTextStyle.copyWith(
                      color: Colors.red,
                    fontWeight:FontWeight.w900
                  ),),)
                ],
              ),
            )
          ],
        ),

      ),

    );


  }
}
