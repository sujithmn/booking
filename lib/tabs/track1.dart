import 'package:booking/model/transit_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TrackScreen extends StatefulWidget {
  const TrackScreen({Key? key}) : super(key: key);
  @override
  _HeadlessInAppWebViewExampleScreenState createState() => _HeadlessInAppWebViewExampleScreenState();
}

class _HeadlessInAppWebViewExampleScreenState
    extends State<TrackScreen> {

  final urlPrefix = 'https://www.tpcglobe.com/tpCWebService/';
  late List<TransitDetail> transitDetails = [] ;
  String searchString = '';
  String statusToShow = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: TextField(
            decoration: const InputDecoration(
              hintText: 'type AWB Number...',
              hintStyle: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
              border: InputBorder.none,
            ),
            style: const TextStyle(
              color: Colors.white,
            ),
            onChanged: (text){
              searchString = text;
             // statusToShow = '';
              setState(() {
                transitDetails = [];
              });
              },
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                getFinalStatus() ;
              });
            },
            icon: Icon(Icons.search),
          )
        ],
        centerTitle: true,
      ),
        body: Container(
            padding: EdgeInsets.all(15),
            color: Colors.white70,
            child: Column(
              children: <Widget>[
            Flexible(
            child:
                Text(
                  statusToShow,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 14.0,
                    fontFamily: "Caveat",
                  ),
                ),
            ),

                  Visibility(
                    visible: statusToShow.length>0,
                    child:
                    Container(
                      width: MediaQuery.of(
                        context,
                      ).size.width,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                      margin: const EdgeInsets.only(left: 100.0, right: 100.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            15,
                          ),
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey.shade200,
                              offset: Offset(2, 4),
                              blurRadius: 5,
                              spreadRadius: 2),
                        ],
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xffc23510),
                            Color(0xfff48020),
                          ],
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            getTrackerDetails();
                            //_showCharges = !_showCharges;
                          });
                          // print("_tabTextIndexSelected: $_tabTextIndexSelected");
/*                Navigator.push(
                  context,
                  document(),
                );*/
                        },
                        child: const Text(
                          "View Details",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )

                  ),
              const SizedBox(
                height: 20,
              ),
                SizedBox(
                      height: MediaQuery.of(context).size.width * 0.90,
              child:
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: transitDetails.length,
                itemBuilder: (con, ind) {
                  return ind != 0
                      ? Column(mainAxisSize: MainAxisSize.min, children: [
                    Row(children: [
                      Column(
                        children: List.generate(
                          2,
                              (ii) => Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 5, bottom: 5),
                              child: Container(
                                height: 3,
                                width: 2,
                                color: Colors.grey,
                              )),
                        ),
                      ),
                      Expanded(
                          child: Container(
                            color: Colors.grey.withAlpha(60),
                            height: 0.5,
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 20,
                            ),
                          ))
                    ]),
                    Row(children: [
                      const Icon(Icons.location_on, color: Colors.blue),
                      Text(transitDetails[ind].sysDt, style: const TextStyle(color: Colors.black87)),
                      const Text(" "),
                      Text(transitDetails[ind].activity, style: const TextStyle(color: Colors.black)),
                     // Text(transitDetails[ind].city,style: TextStyle(color: Colors.black))
                    ])
                  ])
                      : Row(children: [
                    const Icon(Icons.location_on, color: Colors.blue),
                    Text(transitDetails[ind].sysDt, style: const TextStyle(color: Colors.black87)),
                    const Text(" "),
                    Text(transitDetails[ind].activity, style: const TextStyle(color: Colors.black)),
                  //  Text(transitDetails[ind].city,style: TextStyle(color: Colors.black))

                  ]);
                })
            ),
              ]
            )
        )
    );
  }

  //final urlPrefix = 'https://www.tpcglobe.com/tpCWebService/';
  Future<void> getFinalStatus() async {
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

}

