import '../model/transit_details.dart';
import '../widgets/delivery_processes.dart';
import 'bloc.dart';
import 'globals.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class TrackerBloc extends Bloc {

  final deliveryProcessController = StreamController<List<DeliveryProcess>>.broadcast();
  final deliveryStatusController = StreamController<String>.broadcast();

  @override
  void dispose() {
    deliveryProcessController.close();
    deliveryStatusController.close();
  }

  Future<void> getFinalStatus(String searchString) async {
    String uristr = '$urlPrefix/MTRACKde.ASHX?PODNO=$searchString';
    print(uristr);
    final url = Uri.parse(uristr);
    http.Response response = await http.get(url);
    debugResponse(response);
    if (response.statusCode == 200) {
      deliveryStatusController.sink.add(response.body);
    }
  }

  Future<void> getDailyTrackDetailsToBuildTimeline(String searchString) async {
    String uristr = '$urlPrefix/MTRACK.ASHX?PODNO=$searchString';
    print(uristr);
    final url = Uri.parse(uristr);
    http.Response response = await http.get(url);
    debugResponse(response);
    if (response.statusCode == 200) {
      List<DeliveryProcess> deliveryProcess = processJSONData(transitDetailFromJson(response.body));
      deliveryProcessController.sink.add(deliveryProcess);
    }
  }

  debugResponse(http.Response response){
    print('Status code: ${response.statusCode}');
    print('Headers: ${response.headers}');
    print('Body: ${response.body}');
  }

  List<DeliveryProcess> processJSONData(List<TransitDetail> transitDetails){
    String date='';
    var deliveryProcesses = <DeliveryProcess>[];
    DeliveryProcess _deliveryProcess = DeliveryProcess("test");
    for(final tsDetail in transitDetails!){
      if(date!=tsDetail.sysDt) {
        _deliveryProcess = DeliveryProcess(tsDetail.sysDt+ " "+tsDetail.time +" -  "+tsDetail.activity);
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

}