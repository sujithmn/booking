import 'package:flutter/material.dart';
import 'package:chat_app/Tabs/home.dart';
import 'package:chat_app/Tabs/booking.dart';
import 'package:chat_app/Tabs/track.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            // elevation: 0,
            backgroundColor:  Color(0xfff48020),
            title: const Text(
              "Welcome Sujith..!",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

          //TabBar
          bottom: const TabBar(
            unselectedLabelColor: Colors.black87,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            tabs: [
              Tab(
                icon: Icon(Icons.home),
                text:"Home",
              ),
              Tab(
                icon: Icon(Icons.book),
                text:"Booking",
              ),
              Tab(
                icon: Icon(Icons.location_on_rounded),
                text:"Track",
              ),
              Tab(
                icon: Icon(Icons.notifications_none),
                text:"Alerts",
              ),

            ],

          ),
        ),
        body: TabBarView(
          children: const [
            HomeScreen(),
            BookingScreen(),
            TrackScreen(),
            Icon(Icons.notifications_none),
          ],
        ),
      ),
    );
  }
}
