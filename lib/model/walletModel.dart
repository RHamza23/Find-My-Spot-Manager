import 'package:cloud_firestore/cloud_firestore.dart';

class walletModel {
  final String amount;
  final String withdrawMethod;
  final String transectionId;

  walletModel(
      {
        required this.amount,
        required this.withdrawMethod,
        required this.transectionId});

  toJason() {
    return {
      "Amount": amount,
      "Withdraw Method": withdrawMethod,
      "Transection Id": transectionId,
    };
  }

  factory walletModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return walletModel(
        amount: data["Amount"],
        withdrawMethod: data["Withdraw Method"],
        transectionId: data["Transection Id"]);
  }
}
