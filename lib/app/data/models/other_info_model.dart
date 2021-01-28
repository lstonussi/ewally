import 'dart:convert';

class OtherInfo {
  OtherInfo(
      {this.otherAccountName,
      this.userLatitude,
      this.userLongitude,
      this.cupom});

  String otherAccountName;
  double userLatitude;
  double userLongitude;
  String cupom;

  factory OtherInfo.fromRawJson(String str) =>
      OtherInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OtherInfo.fromJson(Map<String, dynamic> json) => OtherInfo(
      otherAccountName:
          json["otherAccountName"] == null ? null : json["otherAccountName"],
      userLatitude:
          json["userLatitude"] == null ? null : json["userLatitude"].toDouble(),
      userLongitude: json["userLongitude"] == null
          ? null
          : json["userLongitude"].toDouble(),
      cupom: json["cupom"] == null ? null : json["cupom"]);

  Map<String, dynamic> toJson() => {
        "otherAccountName": otherAccountName == null ? null : otherAccountName,
        "userLatitude": userLatitude == null ? null : userLatitude,
        "userLongitude": userLongitude == null ? null : userLongitude,
        "cupom": cupom == null ? null : cupom,
      };
}
