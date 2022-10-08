import 'package:booking/model/transit_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:booking/widgets/custom_searchbar.dart';
import 'package:booking/widgets/custom_message.dart';
import 'package:booking/widgets/delivery_processes.dart';



//const kTileHeight = 50.0;
Future<List<TransitDetail>>? futureDelivery;
Future<String>? statusToShow;

const urlPrefix = 'https://www.tpcglobe.com/tpCWebService';
String searchString = '';

class TrackScreen extends StatefulWidget {
  TrackScreen({Key? key}) : super(key: key);
  @override
  _TrackScreenState createState() => _TrackScreenState();
}

bool showDetails=false;
bool showViewDetalsButton = false;

class _TrackScreenState  extends State<TrackScreen> {
  final TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: CustomSearchbar(textController,'type in AWB No...'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                searchString = textController.text;
                if( searchString.length>0) {
                  showDetails = false;
                showViewDetalsButton = true;
                    statusToShow = getFinalStatus();
                }
              });
            },
            icon: const Icon(Icons.search),
          )
        ],
        centerTitle: true,
      ),
      body:
      //Visibility(
     // visible: true,
      //child:
      ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
         // final data = _data(index + 1);
          return Center(
            child: Column(
              children: <Widget>[

                FutureBuilder<String>(
                    future: statusToShow,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return CustomMessage(snapshot.data);
                      }
                      return Container();
                    }),

                Visibility(
                 visible: showViewDetalsButton,
                  child:
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color(0xfff48020)),
                  ),
                  onPressed: () {
                    setState(() {
                      showDetails = true;
                      futureDelivery = getTrackerDetails();
                    });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                  },
                  child: const Text('More Details..'),
                ),
                ),

            Container(
              width: 360.0,
              child: Card(
                margin: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Divider(height: 1.0),

                Visibility(
                  visible: showDetails,
                  child:
    FutureBuilder<List<TransitDetail>>(
    future: futureDelivery,
    builder: (context, snapshot) {
        if (snapshot.hasData) {
          return DeliveryProcesses(processes: processJSONData(snapshot.data));
        }
        return CircularProgressIndicator();
    }),
                ),

                    Divider(height: 1.0),
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      //child: _OnTimeBar(driver: data.driverInfo),
                    ),
                  ],
                ),
              ),
            ),


        //),



          ],
            ),
          );
        },
      ),

    );
  }
}

/*

_OrderInfo _data(int id) {
  getTrackerDetails();
  return _OrderInfo(
    id: id,
    date: DateTime.now(), deliveryProcesses: [],
  );
}


class _OrderInfo {
  const _OrderInfo({
    required this.id,
    required this.date,
  //  required this.driverInfo,
    required this.deliveryProcesses,
  });

  final int id;
  final DateTime date;
//  final _DriverInfo driverInfo;
  final List<DeliveryProcess> deliveryProcesses;
}

*/




  Future<String> getFinalStatus() async {
    String uristr = '$urlPrefix/MTRACKde.ASHX?PODNO=$searchString';
    print(uristr);
    final url = Uri.parse(uristr);
    http.Response response = await http.get(url);
    print('Status code: ${response.statusCode}');
    print('Headers: ${response.headers}');
    print('Body: ${response.body}');
    return '${response.body}';
  }




  Future<List<TransitDetail>> getTrackerDetails() async {
   // searchString = textController.text;
    // String params = 'username=$user.username&mobile=$user.mobile&email=$user.email&pswd=$user.pswd&lati=$user.lati&longi=$user.longi';
    String uristr = '$urlPrefix/MTRACK.ASHX?PODNO=$searchString';
    print(uristr);
    final url = Uri.parse(uristr);
    http.Response response = await http.get(url);
    print('Status code: ${response.statusCode}');
    print('Headers: ${response.headers}');
    print('Body: ${response.body}');
    String body = '${response.body}';
    return transitDetailFromJson(body);
  }

List<DeliveryProcess> processJSONData(List<TransitDetail>? transitDetails){
  String date='';
  ///var messages = <DeliveryMessage>[];
  var deliveryProcesses = <DeliveryProcess>[];
  DeliveryProcess _deliveryProcess = DeliveryProcess("test");
  for(final tsDetail in transitDetails!){
    if(date!=tsDetail.sysDt) {
      _deliveryProcess = DeliveryProcess(tsDetail.sysDt+ " | "+tsDetail.activity);
      _deliveryProcess.messages = <DeliveryMessage>[];
      deliveryProcesses.add(_deliveryProcess);
      date = tsDetail.sysDt;
    }else {
      DeliveryMessage _deliveryMessage = DeliveryMessage(
          tsDetail.time, tsDetail.activity);
      _deliveryProcess.messages.add(_deliveryMessage);
    }
  }
  return deliveryProcesses;
}




