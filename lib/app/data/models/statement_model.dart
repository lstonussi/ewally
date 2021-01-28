import 'package:ewally/app/data/models/other_info_model.dart';

class StatementModel {
  StatementModel({
    this.id,
    this.accountName,
    this.amount,
    this.balance,
    this.createdAt,
    this.operationType,
    this.status,
    this.otherInfo,
  });

  int id;
  String accountName;
  int amount;
  int balance;
  DateTime createdAt;
  String operationType;
  String status;
  OtherInfo otherInfo;
  double get amountConverted {
    return amount / 100;
  }

  factory StatementModel.fromJson(Map<String, dynamic> json) => StatementModel(
        id: json["id"] == null ? null : json["id"],
        accountName: json["accountName"] == null ? null : json["accountName"],
        amount: json["amount"] == null ? null : json["amount"],
        balance: json["balance"] == null ? null : json["balance"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        operationType:
            json["operationType"] == null ? null : json["operationType"],
        status: json["status"] == null ? null : json["status"],
        otherInfo: json["otherInfo"] == null
            ? null
            : OtherInfo.fromJson(
                json["otherInfo"],
              ),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "accountName": accountName == null ? null : accountName,
        "amount": amount == null ? null : amount,
        "balance": balance == null ? null : balance,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "operationType": operationType == null ? null : operationType,
        "status": status == null ? null : status,
        "otherInfo": otherInfo == null ? null : otherInfo.toJson(),
      };
}
