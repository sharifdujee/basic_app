import 'package:flutter/material.dart';
import 'package:local_event_app/model/event.dart';
import 'package:local_event_app/ui/event_details/event_details_background.dart';
import 'package:local_event_app/ui/event_details/event_details_content.dart';
import 'package:local_event_app/ui/home_page/home_page.dart';
import 'package:provider/provider.dart';

class EventDetailsPage extends StatefulWidget {
  const EventDetailsPage({super.key, required this.event});
  final Event event;

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}
int selectedIndex = 0;
late  Event event;

class _EventDetailsPageState extends State<EventDetailsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Provider<Event>.value(
        value: widget.event,
        child: Stack(
          fit: StackFit.expand,
          children: [
            EventDetailsBackground(),
            const EventDetailsContent()
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () => _itemTapped(0),
            ),
            IconButton(
              icon: const Icon(Icons.follow_the_signs),
              onPressed: () => _itemTapped(1),
            ),
          ],
        ),
      ),


    );
  }

  void _itemTapped(int index){
    setState(() {
      selectedIndex = index;
    });
    if(selectedIndex ==0){
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const HomePage()));
    }
    if(selectedIndex ==1){
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> EventDetailsPage(event: widget.event)));
    }


  }


}

