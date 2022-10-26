import 'package:booking/model/transit_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:booking/widgets/custom_searchbar.dart';
import 'package:booking/widgets/custom_message.dart';
import 'package:booking/widgets/delivery_processes.dart';
import 'package:booking/bloc/tracker_bloc.dart';
import 'package:booking/bloc/globals.dart';

Future<List<TransitDetail>>? futureDelivery;
Future<String>? statusToShow;
class TrackScreen extends StatefulWidget {
  TrackScreen({Key? key}) : super(key: key);
  @override
  _TrackScreenState createState() => _TrackScreenState();
}

bool showDetails=false;
bool showViewDetalsButton = false;
String result='';

class _TrackScreenState  extends State<TrackScreen> {
  final TextEditingController textController = TextEditingController();
  final TrackerBloc _trackerBloc = TrackerBloc();
  String searchString = '';

  @override
  void dispose() {
    _trackerBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: CustomSearchbar(textController,'type in AWB No...'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              if(searchString!=textController.text){
                searchString = textController.text;
                _trackerBloc.getFinalStatus(searchString);
                setState(() {
                  showDetails = true;
                });
              }
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

                _getFinalDevlieryStatus(context),

               // Visibility(
                // visible: showDetails,
                //  child:
                showDetails ?
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color(0xfff48020)),
                  ),
                  onPressed: () {
                    _trackerBloc.getDailyTrackDetailsToBuildTimeline(searchString);
                    setState(() {
                      showViewDetalsButton = true;
                    });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                  },
                  child: const Text('More Details..'),
                ):Container(),
                //),

            Container(
              width: 360.0,
              child: Card(
                margin: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Divider(height: 1.0),

                Visibility(
                  visible: showViewDetalsButton,
                  child:
                  _getDeliveryProcesses(context)
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

/*  Future<String> _getDeliveryStatus() async {
    String uristr = '$urlPrefix/MTRACKde.ASHX?PODNO=$searchString';
    final response = await http.get(Uri.parse(uristr));
    print (response.body);
    if (response.statusCode == 200) {
      return response.body;
    }
    return "";
  }*/



  Widget _getFinalDevlieryStatus(BuildContext context){
    return StreamBuilder<String>(
        stream: _trackerBloc.deliveryStatusController.stream,
        builder:(context, snapshot) {
          if (snapshot.hasData) {
            return CustomMessage(snapshot.data);
          }
          return Container();
        }
    );
  }
  Widget _getDeliveryProcesses(BuildContext context){
    return StreamBuilder<List<DeliveryProcess>>(
      stream: _trackerBloc.deliveryProcessController.stream,
      builder:(context, snapshot) {
        if (snapshot.hasData) {
          return DeliveryProcesses(processes: snapshot.data!);
        }
        return CircularProgressIndicator();
      }
    );
  }
}
