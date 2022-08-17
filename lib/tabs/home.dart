// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables


import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinbox/cupertino.dart';

import 'package:chat_app/pages/landing_page.dart';
import 'package:chat_app/pages/charges.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
 // int val=0;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  var _tabTextIndexSelected = 0;
  var _tabTextIndexSelected1 = 0;
  var _listTextTabToggle = ["Document", "Non-Document"];

  var _isInternational = false;
  var xx = ["Domestic", "International"];

  var _weightMeasure = ["Grams","Kgs"];

  var _isNonDocument = false;

  var _nexButtonContent = ["Calculate Charges","Choose Content"];

  double _fontSize = 14;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blue,
      child: ListView(
        children: [
          SizedBox(
            height: 10,
          ),

          FlutterToggleTab(
            // width in percent
            width: 100,
            borderRadius: 30,
            height: 40,
            selectedIndex: _tabTextIndexSelected1,
            selectedBackgroundColors: [Color(0xfff48020), Color(0xffffcb05)],
            selectedTextStyle: TextStyle(
                color: Colors.white,
                fontSize: _fontSize,
                fontWeight: FontWeight.w700),
            unSelectedTextStyle: TextStyle(
                color: Colors.blue,
                fontSize: _fontSize,
                fontWeight: FontWeight.w500),
            labels: xx,
            selectedLabelIndex: (index1) {
              _isInternational = index1>0;
              setState(() {
                _tabTextIndexSelected1 = index1;
              });
            },
            isScroll: false,
          ),

      Visibility(
        visible: _isInternational,
          child:Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Destination Country",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: _fontSize,
                    ),
                  ),
               SizedBox(
                 height: 30.0,
                  child:TextField(
                    style: TextStyle(
                      fontSize: _fontSize,
                    ),
                    textAlign: TextAlign.start,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: "Country to deliver",
                      prefixIcon: Icon(
                        Icons.map,
                        color: Colors.orange,
                      ),
                      border: UnderlineInputBorder(),
                      fillColor: Color(
                        0xfff3f3f4,
                      ),
                      filled: true,
                    ),
                  ),
              ),
                ],
              ),
            ),
          ),
      ),

          // 3rd Layer Closed

          // 4th Layer Open (Story & Friends)
      Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Container(
            margin: EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Pickup Pincode",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: _fontSize,
                  ),
                ),

            SizedBox(
              height: 30.0,
              child:TextField(
                  style: TextStyle(
                    fontSize: _fontSize,
                  ),
                  textAlign: TextAlign.start,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: "pickup pincode",
                    suffixText:"BANGALORE",
                    suffixStyle: TextStyle(color: Colors.blue,
                        fontSize: _fontSize),
                    suffixIcon: Icon(
                      Icons.add_task,
                      color: Colors.orange,
                    ),
                    prefixIcon: Icon(
                      Icons.delivery_dining,
                      color: Colors.orange,
                    ),
                    border: UnderlineInputBorder(),
                    fillColor: Color(
                      0xfff3f3f4,
                    ),
                    filled: true,
                  ),
                ),
            ),
              ],
            ),
          ),
      ),

          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Delivery Pincode",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: _fontSize,
                    ),
                  ),

              SizedBox(
                height: 30.0,
                child:TextField(
                    style: TextStyle(
                      fontSize: _fontSize,
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                    textAlign: TextAlign.start,
                   // obscureText: false,
                    decoration: InputDecoration(
                      hintText: "delivery pincode",
                      suffixText:"BANGALORE",
                      suffixIcon: Icon(
                        Icons.add_task,
                        color: Colors.orange,
                      ),
                      suffixStyle: TextStyle(color: Colors.blue,
                          fontSize: _fontSize),
                      prefixIcon: Icon(
                        Icons.location_on_rounded,
                        color: Colors.orange,
                      ),
                      border: UnderlineInputBorder(),
                      fillColor: Color(
                        0xfff3f3f4,
                      ),
                      filled: true,
                    ),
                  ),
              ),
                ],
              ),
            ),
          ),

          SizedBox(
            height: 20,
          ),

          FlutterToggleTab(
            // width in percent
            width: 100,
            borderRadius: 30,
            height: 40,
            selectedIndex: _tabTextIndexSelected,
            selectedBackgroundColors: [Color(0xfff48020), Color(0xffffcb05)],
            //selectedBackgroundColors: [Colors.blue, Colors.blueAccent],
            selectedTextStyle: TextStyle(
                color: Colors.white,
                fontSize: _fontSize,
                fontWeight: FontWeight.w700),
            unSelectedTextStyle: TextStyle(
                color: Colors.blue,
                fontSize: _fontSize,
                fontWeight: FontWeight.w500),
            labels: _listTextTabToggle,
            selectedLabelIndex: (index) {
              //print("VALUE>>>>>>>>>>>>>>>> : $index");

              _isNonDocument = index>0;
              setState(() {
                _tabTextIndexSelected = index;
              });
            },
            isScroll: false,
          ),

   /*   Text(
        "Weight of ${_listTextTabToggle[_tabTextIndexSelected]} ",
        style: TextStyle(fontSize: 20),
      ),
*/

      Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              child: Text('Weight ('+_weightMeasure[_tabTextIndexSelected]+') ',
                  style: TextStyle(fontSize: _fontSize,
                      color: Colors.blue,
                      )),
              padding: const EdgeInsets.only(left: 16, top: 5),
            ),
          Padding(
            child: CupertinoSpinBox(
              suffix: Text(_weightMeasure[_tabTextIndexSelected]),
              max: 3000.0,
              value: 0,
              decimals: 2,
              step: 0.1,
              decoration: const BoxDecoration(
                border: Border.symmetric(
                  vertical: BorderSide(
                    width: 0,
                    color: CupertinoColors.inactiveGray,
                  ),
                ),
                color: CupertinoDynamicColor.withBrightness(
                  color: CupertinoColors.white,
                  darkColor: CupertinoColors.black,
                ),
              ),


            ),
            padding: const  EdgeInsets.only(left: 60.0),
          ),
          ],
      ),


      Visibility(
        visible: _isNonDocument,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                child: Text('Length (cm) ', style: TextStyle(fontSize: _fontSize,
                    color: Colors.blue,
                    )),
                padding: const EdgeInsets.only(left: 16, top: 1),
              ),
              Padding(
                child: CupertinoSpinBox(
                  suffix: Text('cm'),
                  max: 999.0,
                  value: 0,
                  step: 1,
                  decoration: const BoxDecoration(
                    border: Border.symmetric(
                      vertical: BorderSide(
                        width: 0,
                        color: CupertinoColors.inactiveGray,
                      ),
                    ),
                    color: CupertinoDynamicColor.withBrightness(
                      color: CupertinoColors.white,
                      darkColor: CupertinoColors.black,
                    ),
                  ),


                ),
                padding: const  EdgeInsets.only(left: 60.0),
              ),

              Padding(
                child: Text('Width (cm) ', style: TextStyle(fontSize: _fontSize,
                    color: Colors.blue,
                    )),
                padding: const EdgeInsets.only(left: 16, top: 1),
              ),

              Padding(
                child: CupertinoSpinBox(
                  suffix: Text('cm'),
                  max: 999.0,
                  value: 0,
                  step: 1,
                  decoration: const BoxDecoration(
                    border: Border.symmetric(
                      vertical: BorderSide(
                        width: 0,
                        color: CupertinoColors.inactiveGray,
                      ),
                    ),
                    color: CupertinoDynamicColor.withBrightness(
                      color: CupertinoColors.white,
                      darkColor: CupertinoColors.black,
                    ),
                  ),

                ),
                padding: const  EdgeInsets.only(left: 60.0),
              ),

              Padding(
                child: Text('Height (cm) ', style: TextStyle(fontSize: _fontSize,
                    color: Colors.blue,
                    )),
                padding: const EdgeInsets.only(left: 16, top: 1),
              ),

              Padding(
                child: CupertinoSpinBox(
                  suffix: Text('cm'),
                  max: 999.0,
                  value: 0,
                  step: 1,
                  decoration: const BoxDecoration(
                    border: Border.symmetric(
                      vertical: BorderSide(
                        width: 0,
                        color: CupertinoColors.inactiveGray,
                      ),
                    ),
                    color: CupertinoDynamicColor.withBrightness(
                      color: CupertinoColors.white,
                      darkColor: CupertinoColors.black,
                    ),
                  ),


                ),
                padding: const  EdgeInsets.only(left: 60.0),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Declared Value",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: _fontSize,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                  SizedBox(
                    height: 30.0,
                    child:TextField(
                        style: TextStyle(
                          fontSize: _fontSize,
                        ),
                        textAlign: TextAlign.start,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: "Declared Value",
                          prefixIcon: Icon(
                            Icons.money,
                            color: Colors.orange,
                          ),
                          border: UnderlineInputBorder(),
                          fillColor: Color(
                            0xfff3f3f4,
                          ),
                          filled: true,
                        ),
                      ),
                  ),
                    ],
                  ),
                ),
              ),

            ],
          ),


      ),


          SizedBox(
            height: 10,
          ),

          Container(
            width: MediaQuery.of(
              context,
            ).size.width,
            padding: EdgeInsets.symmetric(
              vertical: 12,
            ),
            margin: const EdgeInsets.only(left: 40.0, right: 40.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
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
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: const [
                  Color(0xfff48020),
                  Color(0xffffcb05),
                ],
              ),
            ),
            child: InkWell(
              onTap: () {
               // print("_tabTextIndexSelected: $_tabTextIndexSelected");
                Navigator.push(
                  context,
                  document(),
                );
              },
              child: Text(
                _nexButtonContent[_tabTextIndexSelected],
                style: TextStyle(
                  fontSize: _fontSize,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          SizedBox(
            height: 20,
          ),

        ],
      ),
    );
  }
  MaterialPageRoute document(){
    if(_tabTextIndexSelected==0) {
      return MaterialPageRoute(
        //  _tabTextIndexSelected
        builder: (context) => ChargesScreen(),
      );
    }
    return MaterialPageRoute(
      //  _tabTextIndexSelected
      builder: (context) => ChargesScreen(),
    );
  }
  Widget nonDocument(){
    return new Container();
  }
}
