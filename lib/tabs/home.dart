// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinbox/cupertino.dart';
import 'package:geocode/geocode.dart';

import 'package:http/http.dart' as http;

import 'package:booking/charges_request.dart';
import 'package:booking/charges_response.dart';

import 'package:booking/widgets/booking_options.dart';
import 'package:booking/bloc/globals.dart';

import '../screens/address_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  // int val=0;
  @override
  _HomePageState createState() => _HomePageState();
}

enum Shipment { Standard, PiorityClass, PROPremium, None }
enum Risk { NoRisk, OwnerRisk, CarrierRisk }
var _showCharges = false;

class _HomePageState extends State<HomeScreen> {

  ChargesRequest chargesRequest = ChargesRequest();
  late ChargesResponse chargesResponse = ChargesResponse(std: '0', pro: '0', prc: '0');
  var _tabDocNondocIndexSelected = 0;
  var _tabDomIntlIndexSelected = 0;
  final _tabDocumentNondocument = ["Document", "Non-Document"];
  var _isInternational = false;
  final _tabDomesticInternational = ["Domestic", "International"];
  final _weightMeasure = ["Grams", "Kgs"];
  var _isNonDocument = false;
  double _fontSize = 16;
  String dropdownvalue = 'Select items to send';
  var deliveryClasses =[
    'PROPremium',
    'Priority Class',
    'Standard',
  ];
  // List of items in our dropdown menu
  var items = [
    'Select items to send',
    'Artificial Jewellery',
    'Computer peripherals',
    'Electronic items',
    'Furniture',
  ];
  Shipment? _shipmentCharges = Shipment.None;
  Risk? _risk;
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blue,
      child: Form(
        key: _formKey,
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
            selectedIndex: _tabDomIntlIndexSelected,
            selectedBackgroundColors: [
              Color(0xffc23510),
              Color(0xfff48020),
            ],
            selectedTextStyle: TextStyle(
                color: Colors.white,
                fontSize: _fontSize,
                fontWeight: FontWeight.w700),
            unSelectedTextStyle: TextStyle(
                color: Colors.black,
                fontSize: _fontSize,
                fontWeight: FontWeight.w500),
            labels: _tabDomesticInternational,
            selectedLabelIndex: (index1) {
              _isInternational = index1 > 0;
              setState(() {
                _tabDomIntlIndexSelected = index1;
              });
            },
            isScroll: false,
          ),

          Visibility(
            visible: _isInternational,
            child: Padding(
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
                      child: TextFormField(
                        onChanged: (value){
                          chargesRequest.country = value;
                        },
                        validator: (value) {
                          if (_isInternational  && (value == null || value.isEmpty)) {
                            return 'Please enter Country';
                          }
                          return null;
                        },
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
                    height: 50.0,
                    child: TextFormField(
                      onChanged: (value){
                        chargesRequest.origin = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Pickup Pincode';
                        }
                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        LengthLimitingTextInputFormatter(6),
                      ],
                      style: TextStyle(
                        fontSize: _fontSize,
                      ),
                      textAlign: TextAlign.start,
                      obscureText: false,
                      decoration: InputDecoration(
                        //hintText: "pickup pincode",
                        //suffixText: "BANGALORE",
                        ///suffixStyle:
                        //    TextStyle(color: Colors.blue, fontSize: _fontSize),
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
                    height: 50.0,
                    child: TextFormField(
                        onChanged: (value){
                           chargesRequest.destn = value;
                        },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Delivery Pincode';
                        }
                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        LengthLimitingTextInputFormatter(6),
                      ],
                      style: TextStyle(
                        fontSize: _fontSize,
                      ),

                      textAlign: TextAlign.start,
                      // obscureText: false,
                      decoration: InputDecoration(
                        //hintText: "delivery pincode",
                        //suffixText: "BANGALORE",
                        suffixIcon: Icon(
                          Icons.add_task,
                          color: Colors.orange,
                        ),
                        //suffixStyle:
                         //   TextStyle(color: Colors.blue, fontSize: _fontSize),
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
            selectedIndex: _tabDocNondocIndexSelected,
            selectedBackgroundColors: [
              Color(0xffc23510),
              Color(0xfff48020),
            ],
            //selectedBackgroundColors: [Colors.blue, Colors.blueAccent],
            selectedTextStyle: TextStyle(
                color: Colors.white,
                fontSize: _fontSize,
                fontWeight: FontWeight.w700),
            unSelectedTextStyle: TextStyle(
                color: Colors.black,
                fontSize: _fontSize,
                fontWeight: FontWeight.w500),
            labels: _tabDocumentNondocument,
            selectedLabelIndex: (index) {
              _isNonDocument = index > 0;
              setState(() {
                _tabDocNondocIndexSelected = index;
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
                child: Text(
                    'Weight (' + _weightMeasure[_tabDocNondocIndexSelected] + ') ',
                    style: TextStyle(
                      fontSize: _fontSize,
                      color: Colors.blue,
                    )),
                padding: const EdgeInsets.only(left: 16, top: 5),
              ),
              Padding(
                child: CupertinoSpinBox(
                  suffix: Text(_weightMeasure[_tabDocNondocIndexSelected]),
                  max: 3000.0,
                  value: 0,
                  decimals: 2,
                  step: 0.1,
                    onChanged: (double? newValue) {
                        chargesRequest.weight = newValue!;
                    },
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
                padding: const EdgeInsets.only(left: 60.0),
              ),
            ],
          ),

          Visibility(
            visible: _isNonDocument,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  child: Text('Length (cm) ',
                      style: TextStyle(
                        fontSize: _fontSize,
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
                    onChanged: (double? newValue) {
                      chargesRequest.length = newValue!;
                    },
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
                  padding: const EdgeInsets.only(left: 60.0),
                ),
                Padding(
                  child: Text('Width (cm) ',
                      style: TextStyle(
                        fontSize: _fontSize,
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
                    onChanged: (double? newValue) {
                      chargesRequest.width = newValue!;
                    },
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
                  padding: const EdgeInsets.only(left: 60.0),
                ),
                Padding(
                  child: Text('Height (cm) ',
                      style: TextStyle(
                        fontSize: _fontSize,
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
                    onChanged: (double? newValue) {
                      chargesRequest.height = newValue!;
                    },
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
                  padding: const EdgeInsets.only(left: 60.0),
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
                          height: 40.0,
                          child: TextField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                              LengthLimitingTextInputFormatter(6),
                            ],
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
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 40.0,
                          child: DropdownButtonFormField(
                            // Initial Value
                            value: dropdownvalue,

                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                              });
                            },
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
            margin: const EdgeInsets.only(left: 100.0, right: 100.0),
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
                  Color(0xffc23510),
                  Color(0xfff48020),
                ],
              ),
            ),
            child: InkWell(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  makeGetRequest();
                  validate();
                  setState(() {
                    _showCharges = true;
                  });
                }
              },
              child: Text(
              "Calculate Charges",
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

          Visibility(
            visible: _showCharges,
            child: Column(

              children: [
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          Radio<Shipment>(
                            value: Shipment.Standard,
                            groupValue: _shipmentCharges,
                            onChanged: (Shipment? value) {
                              setState(() {
                                _shipmentCharges = value;
                              });
                            },
                          ),
                          Expanded(
                              child: Text(
                                deliveryClasses[2],
                                maxLines: 2,
                              ))
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                           Text('\u{20B9}${chargesResponse.std}/-')
                        ],
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          Radio<Shipment>(
                            value: Shipment.PiorityClass,
                            groupValue: _shipmentCharges,
                            onChanged: (Shipment? value) {
                              setState(() {
                                _shipmentCharges = value;
                              });
                            },
                          ),
                          Text(deliveryClasses[1])
                        ],
                      ),
                    ),

                    Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          Text('\u{20B9}${chargesResponse.prc}/-')
                        ],
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          Radio<Shipment>(
                            value: Shipment.PROPremium,
                            groupValue: _shipmentCharges,
                            onChanged: (Shipment? value) {
                              setState(() {
                                _shipmentCharges = value;
                              });
                            },
                          ),
                          Text(deliveryClasses[0])
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          Text('\u{20B9}${chargesResponse.pro}/-')
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height:20),
/*                Divider(
                    color: Colors.black
                ),*/
                header("Risk Surcharges"),

                //--

                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          Radio<Risk>(
                            value: Risk.NoRisk,
                            groupValue: _risk,
                            onChanged: (Risk? value) {
                              setState(() {
                                _risk = value;
                              });
                            },
                          ),
                          Flexible(
                            flex: 1,
                            child: Row(
                              children: [
                                Text('No Risk 0% of the cost')
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),


                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          Radio<Risk>(
                            value: Risk.OwnerRisk,
                            groupValue: _risk,
                            onChanged: (Risk? value) {
                              setState(() {
                                _risk = value;
                              });
                            },
                          ),
                          Flexible(
                            flex: 1,
                            child:
                                Text('Owner risk = 0.2% of the Declared value of Rs.26 (which ever is higher)')
                          ),
                        ],
                      ),
                    ),
                  ],
                ),


                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          Radio<Risk>(
                            value: Risk.CarrierRisk,
                            groupValue: _risk,
                            onChanged: (Risk? value) {
                              setState(() {
                                _risk = value;
                              });
                            },
                          ),
                          Flexible(
                            flex: 1,
                            child:
                                Text('Carier risk 2% of the Declared value or Rs.25 (which ever is higher)')
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Divider(
                    color: Colors.black
                ),
                //--
      Visibility(
        visible: _shipmentCharges!=Shipment.None,
        child: Column(

    children: [
                header("Pickup Address"),
                fromAddress("Address1","pincode1"),
                header("Delivery Address"),
                fromAddress("Address2","pincode2"),

                header("Booking Options"),
                BookingOptions(),


    ]
        ),
      ),
                SizedBox(
                height: 20,
              ),
              ],

            ),

          ),
        ],
      ),
      ),
    );
  }

  Widget header(String title){
    return Card(
      child: Container(
        color: Colors.white,
        height: 30,
        child: Center(child: Text(title),),
      ),
    );
  }

  Widget fromAddress(String title, String subtitle) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.mail),
              title: Text(title),
              subtitle: Text(subtitle),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('Add New'),
                  onPressed: () {
                    Navigator.of(context).push(_createRoute());
                  },
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('Edit'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>  AddressPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }





  Future<String> _getAddress(double? lat, double? lang) async {
    if (lat == null || lang == null) return "";
    GeoCode geoCode = GeoCode();
    Address address =
    await geoCode.reverseGeocoding(latitude: lat, longitude: lang);
    return "${address.streetAddress}, ${address.city}, ${address.countryName}, ${address.postal}";
  }
  bool validate(){
      print("===============");
      print(chargesRequest);
      print("===============");
      return false;
  }
  Future<void> makeGetRequest() async {
    // String params = 'username=$user.username&mobile=$user.mobile&email=$user.email&pswd=$user.pswd&lati=$user.lati&longi=$user.longi';
    print('Param $chargesRequest');
    var response = await http.get(Uri.parse('$urlPrefix/calculaterate.aspx?$chargesRequest'));
    final parsedJson = jsonDecode(response.body);
    chargesResponse = ChargesResponse.fromJson(parsedJson);
    print('Status code: ${response.statusCode}');
    print('Headers: ${response.headers}');
    print('Body: ${response.body}');
    print('chargesResponse: $chargesResponse');
  //  print('${parsedJson.runtimeType} : $parsedJson');
  }
}

