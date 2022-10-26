import 'package:booking/widgets/custom_searchbar.dart';
import 'package:booking/widgets/network_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:booking/bloc/globals.dart';

class NetworkScreen extends StatefulWidget {
  const NetworkScreen({Key? key}) : super(key: key);
  @override
  _BookingPageState createState() => _BookingPageState();
}

var searchString="";
Future<String>? jsonResult;

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
    setState(() {
      searchString = textController.text;
        if(searchString.length==6) {
          jsonResult = getFinalStatus();
        }
    });
              },
              icon: const Icon(Icons.search),
            )
          ],
          centerTitle: true,
        ),

    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children:  [
        SizedBox(
          height: 20,
        ),

        FutureBuilder<String>(
            future: jsonResult,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return NetworkCard(snapshot.data);
              }
              return Container();
            }),

      ]
    )
    );
  }




  Future<String> getFinalStatus() async {
    String uristr = '$urlPrefix/getcity.ashx?pincode=$searchString';
    print(uristr);
    final url = Uri.parse(uristr);
    http.Response response = await http.get(url);
    print('Status code: ${response.statusCode}');
    print('Headers: ${response.headers}');
    print('Body: ${response.body}');
    return response.body;
  }

}