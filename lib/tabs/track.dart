import 'package:booking/model/transit_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:timelines/timelines.dart';
import '../widget.dart';
import 'package:booking/widgets/custom_searchbar.dart';

final TextEditingController textController = TextEditingController();

//const kTileHeight = 50.0;
class TrackScreen extends StatelessWidget  {
   TrackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomSearchbar(textController,'type in AWB No...'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              getFinalStatus();
            },
            icon: const Icon(Icons.search),
          )
        ],
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          final data = _data(index + 1);
          return Center(
            child: Column(
              children: <Widget>[


                Container(
                  margin: const EdgeInsets.only(left: 40, top:10, right: 40, bottom:0),
                  child: Text(
                    statusToShow,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 20.0,
                      fontFamily: "Caveat",
                    ),
                  ),
                ),


                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color(0xfff48020)),
                  ),
                  onPressed: () {
                      getTrackerDetails();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                  },
                  child: const Text('More Details..'),
                ),

            Visibility(
              visible: statusToShow.length>0,
            child:Container(
              width: 360.0,
              child: Card(
                margin: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Divider(height: 1.0),
                    _DeliveryProcesses(processes: data.deliveryProcesses),
                    Divider(height: 1.0),
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      //child: _OnTimeBar(driver: data.driverInfo),
                    ),
                  ],
                ),
              ),
            ),
            ),



          ],
            ),
          );
        },
      ),
    );
  }
}


class _InnerTimeline extends StatelessWidget {
  const _InnerTimeline({
    required this.messages,
  });

  final List<_DeliveryMessage> messages;

  @override
  Widget build(BuildContext context) {
    bool isEdgeIndex(int index) {
      return index == 0 || index == messages.length + 1;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: FixedTimeline.tileBuilder(
        theme: TimelineTheme.of(context).copyWith(
          nodePosition: 0,
          connectorTheme: TimelineTheme.of(context).connectorTheme.copyWith(
            thickness: 1.0,
          ),
          indicatorTheme: TimelineTheme.of(context).indicatorTheme.copyWith(
            size: 10.0,
            position: 0.5,
          ),
        ),
        builder: TimelineTileBuilder(
          indicatorBuilder: (_, index) =>
          !isEdgeIndex(index) ? Indicator.outlined(borderWidth: 1.0) : null,
          startConnectorBuilder: (_, index) => Connector.solidLine(),
          endConnectorBuilder: (_, index) => Connector.solidLine(),
          contentsBuilder: (_, index) {
            if (isEdgeIndex(index)) {
              return null;
            }

            return Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(messages[index - 1].toString()),
            );
          },
          itemExtentBuilder: (_, index) => isEdgeIndex(index) ? 10.0 : 30.0,
          nodeItemOverlapBuilder: (_, index) =>
          isEdgeIndex(index) ? true : null,
          itemCount: messages.length + 2,
        ),
      ),
    );
  }
}

class _DeliveryProcesses extends StatelessWidget {
  const _DeliveryProcesses({Key? key, required this.processes})
      : super(key: key);

  final List<_DeliveryProcess> processes;



  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(
        color: Color(0xff9b9b9b),
        fontSize: 12.5,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FixedTimeline.tileBuilder(
          theme: TimelineThemeData(
            nodePosition: 0,
            color: Color(0xff989898),
            indicatorTheme: const IndicatorThemeData(
              position: 0,
              size: 20.0,
            ),
            connectorTheme: const ConnectorThemeData(
              thickness: 2.5,
            ),
          ),
          builder: TimelineTileBuilder.connected(
            connectionDirection: ConnectionDirection.before,
            itemCount: processes.length,
            contentsBuilder: (_, index) {
              if (processes[index].isCompleted) return null;

              return Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      processes[index].name,
                      style: DefaultTextStyle.of(context).style.copyWith(
                        fontSize: 18.0,
                      ),
                    ),
                    _InnerTimeline(messages: processes[index].messages),
                  ],
                ),
              );
            },
            indicatorBuilder: (_, index) {
              if (processes[index].isCompleted) {
                return const DotIndicator(
                  color: Color(0xff66c97f),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 12.0,
                  ),
                );
              } else {
                return const OutlinedDotIndicator(
                  borderWidth: 2.5,
                );
              }
            },
            connectorBuilder: (_, index, ___) => SolidLineConnector(
              color: processes[index].isCompleted ? Color(0xff66c97f) : null,
            ),
          ),
        ),
      ),
    );
  }
}

_OrderInfo _data(int id) {
  getTrackerDetails();
  return _OrderInfo(
    id: id,
    date: DateTime.now(), deliveryProcesses: [],
  );
}

_OrderInfo _data1(int id) => _OrderInfo(
  id: id,
  date: DateTime.now(),
/*  driverInfo: _DriverInfo(
    name: 'Philipe',
    thumbnailUrl:
    'https://i.pinimg.com/originals/08/45/81/084581e3155d339376bf1d0e17979dc6.jpg',
  ),*/
  deliveryProcesses: [
    _DeliveryProcess(
      'Delivered - Area : KVR',
      messages: [
        _DeliveryMessage('10:09', 'Delivered - Area : KVR'),
        _DeliveryMessage('10:09 ', 'Out for Delivery - Area : KVR'),
      ],
    ),
    _DeliveryProcess(
      'Recieved at Bengaluru',
      messages: [
        _DeliveryMessage('10:23', 'Recieved at Bengaluru - Mysore Road'),
        _DeliveryMessage('10:02', 'Received at Bengaluru'),
        _DeliveryMessage('10:58', 'Recieved at Bengaluru - N R Road'),
      ],
    ),

    _DeliveryProcess(
      'Recieved at Bengaluru',
      messages: [
        _DeliveryMessage('10:58', 'Recieved at Bengaluru - N R Road'),

      ],
    ),

    _DeliveryProcess(
      'Despatched to Bengaluru',
      messages: [
        _DeliveryMessage('10:57', 'Despatched to Bengaluru - Bashyam Circle'),
      ],
    ),

    _DeliveryProcess.complete(),
  ],
);

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
  final List<_DeliveryProcess> deliveryProcesses;
}
/*
class _DriverInfo {
  const _DriverInfo({
    required this.name,
    required this.thumbnailUrl,
  });

  final String name;
  final String thumbnailUrl;
}
*/

class _DeliveryProcess {
  const _DeliveryProcess(
      this.name, {
        this.messages = const [],
      });

  const _DeliveryProcess.complete()
      : this.name = 'Done',
        this.messages = const [];

  final String name;
  final List<_DeliveryMessage> messages;

  bool get isCompleted => name == 'Done';
}

class _DeliveryMessage {
  const _DeliveryMessage(this.createdAt, this.message);

  final String createdAt; // final DateTime createdAt;
  final String message;

  @override
  String toString() {
    return '$createdAt $message';
  }
}

final urlPrefix = 'https://www.tpcglobe.com/tpCWebService/';
late List<TransitDetail> transitDetails = [] ;
String searchString = '';
String statusToShow = '';

  Future<void> getFinalStatus() async {
    searchString = textController.text;
    String uristr = '$urlPrefix/MTRACKde.ASHX?PODNO=$searchString';
    print(uristr);
    final url = Uri.parse(uristr);
    http.Response response = await http.get(url);
    print('Status code: ${response.statusCode}');
    print('Headers: ${response.headers}');
    print('Body: ${response.body}');
    statusToShow = '${response.body}';
  }


Future<void> getTrackerDetails() async {
  searchString = textController.text;
  // String params = 'username=$user.username&mobile=$user.mobile&email=$user.email&pswd=$user.pswd&lati=$user.lati&longi=$user.longi';
  String uristr = '$urlPrefix/MTRACK.ASHX?PODNO=$searchString';
  print(uristr);
  final url = Uri.parse(uristr);
  http.Response response = await http.get(url);
  print('Status code: ${response.statusCode}');
  print('Headers: ${response.headers}');
  print('Body: ${response.body}');
  String body = '${response.body}';
  transitDetails = transitDetailFromJson(body);
}

  Future<void> getTrackerDetails1() async {
    searchString = textController.text;
    // String params = 'username=$user.username&mobile=$user.mobile&email=$user.email&pswd=$user.pswd&lati=$user.lati&longi=$user.longi';
    String uristr = '$urlPrefix/MTRACK.ASHX?PODNO=$searchString';
    print(uristr);
    final url = Uri.parse(uristr);
    http.Response response = await http.get(url);
    print('Status code: ${response.statusCode}');
    print('Headers: ${response.headers}');
    print('Body: ${response.body}');
    String body = '${response.body}';
    transitDetails = transitDetailFromJson(body);
    String date='';
    _DeliveryProcess _deliveryProcess;
    var messages = <_DeliveryMessage>[];
    for(final tsDetail in transitDetails){
      if(date!=tsDetail.sysDt) {
        date = tsDetail.sysDt;
         _deliveryProcess = _DeliveryProcess(tsDetail.activity);
      }
      _DeliveryMessage _deliveryMessage= _DeliveryMessage( tsDetail.time, tsDetail.activity);
      messages.add(_deliveryMessage);

    }
  }



