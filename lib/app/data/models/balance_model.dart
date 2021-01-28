class BalanceModel {
  BalanceModel({
    this.balance,
    this.blockedBalance,
  });

  int balance;
  int blockedBalance;

  double get balanceConverted {
    return balance / 100;
  }

  factory BalanceModel.fromJson(Map<String, dynamic> json) => BalanceModel(
        balance: json["balance"] == null ? null : json["balance"],
        blockedBalance:
            json["blockedBalance"] == null ? null : json["blockedBalance"],
      );

  Map<String, dynamic> toJson() => {
        "balance": balance == null ? null : balance,
        "blockedBalance": blockedBalance == null ? null : blockedBalance,
      };
}
