// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<TransitDetail> transitDetailFromJson(String str) => List<TransitDetail>.from(json.decode(str).map((x) => TransitDetail.fromJson(x)));
String transitDetailToJson(List<TransitDetail> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TransitDetail {
  TransitDetail({
    required this.sysDt,
    required this.time,
    required this.activity,
    required this.wayNo,
    required this.city,
  });

  String sysDt;
  String time;
  String activity;
  String wayNo;
  String city;

  factory TransitDetail.fromJson(Map<String, dynamic> json) => TransitDetail(
    sysDt: json["Sys_dt"],
    time: json["Time"],
    activity: json["Activity"],
    wayNo: json["WayNo"],
    city: json["City"],
  );

  Map<String, dynamic> toJson() => {
    "Sys_dt": sysDt,
    "Time": time,
    "Activity": activity,
    "WayNo": wayNo,
    "City": city,
  };

  String toString() {
    return toJson().toString();
  }
}
