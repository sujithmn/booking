import 'package:flutter/material.dart';
import 'dart:convert';

class NetworkCard extends StatelessWidget {
  final String? jsonText;

  NetworkCard(this.jsonText);

  @override
  Widget build(BuildContext context) {
    String hub = '';
    String city = '';

    try {
      var searchResult = jsonDecode(jsonText!);
       hub = '${searchResult['HUB']}';
       city = '${searchResult['CITY']}';
    } catch (e) {
      hub = 'Error';
      city = e.toString();
      print("***********ERROR start**************");
        print(e);
      print("***********ERROR end **************");
    }

    return Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.location_city),
              title: Text(hub),
              subtitle: Text(city),
            ),
          ],
        )
    );
  }
}