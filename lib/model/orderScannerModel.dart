import 'package:cloud_firestore/cloud_firestore.dart';

class orderScannerModel {
  final String scannerId;
  final String phoneNo;
  final String shipAddress;
  final String implementedlocation;
  final String paymentMethod;
  final String orderStatus;


  orderScannerModel( {
    required this.scannerId,
    required this.phoneNo,
    required this.shipAddress,
    required this.implementedlocation,
    required this.paymentMethod,
    required this.orderStatus,
  });

  toJason() {
    return {
      "ScannerId": scannerId,
      "PhoneNumber": phoneNo,
      "ShipmentAddress": shipAddress,
      "ImplementedAddress": implementedlocation,
      "PaymentMethod": paymentMethod,
      "OrderStatus": orderStatus,

    };
  }

  factory orderScannerModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return orderScannerModel(
        scannerId: data["ScannerId"],
        phoneNo: data["PhoneNumber"],
        shipAddress: data["ShipmentAddress"],
        implementedlocation: data["ImplementedAddress"],
        paymentMethod: data["PaymentMethod"],
        orderStatus: data["OrderStatus"]);
  }
}
