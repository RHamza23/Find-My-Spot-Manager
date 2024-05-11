import 'package:cloud_firestore/cloud_firestore.dart';

class updateFeeModel {
  final String bike;
  final String car;

  updateFeeModel({
    required this.bike,
    required this.car,
  });

  toJason() {
    return {
      "Bike": bike,
      "Car": car,
    };
  }

  factory updateFeeModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return updateFeeModel(
      bike: data["Bike"],
      car: data["Car"],
    );
  }
}
