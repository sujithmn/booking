import 'package:flutter/material.dart';
import 'package:booking/tabs/home.dart';
import 'package:booking/tabs/network.dart';
import 'package:booking/tabs/track.dart';

class LandingPage extends StatelessWidget {
  LandingPage({Key? key}) : super(key: key);

  @override
  void initState() {

  }
  @override
  Widget build(BuildContext context) {
      return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            // elevation: 0,
            backgroundColor:  Colors.red,  //#e20019
            title: const Text(
              "Welcome User..!",
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
                text:"Network",
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
        body:  TabBarView(
          children: [
            HomeScreen(),
            NetworkScreen(),
            TrackScreen(),
            Icon(Icons.notifications_none),
          ],
        ),
      ),
    );
  }
}
