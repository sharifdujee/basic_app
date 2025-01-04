import 'package:flutter/material.dart';
import 'package:local_event_app/model/event.dart';
import 'package:local_event_app/ui/home_page/home_page.dart';

import '../event_details/event_details_page.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}
int selectedIndex = 0;
late  Event event;

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> EventDetailsPage(event: event)));
    }


  }
}
