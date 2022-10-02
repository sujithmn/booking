import 'dart:convert';
import 'package:booking/widgets/custom_searchbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkScreen extends StatefulWidget {
  const NetworkScreen({Key? key}) : super(key: key);
  @override
  _BookingPageState createState() => _BookingPageState();
}

var searchString="";

class _BookingPageState extends State<NetworkScreen> {

  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: CustomSearchbar(textController,'type in AWB No...'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {

              },
              icon: const Icon(Icons.search),
            )
          ],
          centerTitle: true,
        ),

    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(
          height: 20,
        ),
        Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                ListTile(
                  leading: Icon(Icons.location_city),
                  title: Text("test title"),
                  subtitle: Text("test subtitle"),
                ),
              ],
            )
        ),

      ]
    )
    );
  }

  final urlPrefix = 'https://www.tpcglobe.com/tpCWebService';
  var searchResult;
  Future<void> getFinalStatus() async {
    String uristr = '$urlPrefix/getcity.ashx?pincode=$searchString';
    print(uristr);
    final url = Uri.parse(uristr);
    http.Response response = await http.get(url);
    print('Status code: ${response.statusCode}');
    print('Headers: ${response.headers}');
    print('Body: ${response.body}');
    var jsonString = response.body;
    searchResult = jsonDecode(jsonString);
    //print('Howdy, ${searchResult['HUB']}!');
  //  print('Howdy, ${searchResult['CITY']}!');
  }

}