import 'package:flutter/material.dart';
import 'dart:convert';

class NetworkCard extends StatelessWidget {
  final String? jsonText;

  NetworkCard(this.jsonText);

  @override
  Widget build(BuildContext context) {
    var searchResult = jsonDecode(jsonText!);
    String? hub = '${searchResult['HUB']}';
    String city = '${searchResult['CITY']}';

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