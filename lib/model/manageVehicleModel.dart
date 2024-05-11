import 'package:cloud_firestore/cloud_firestore.dart';

class   manageVehicleModel {
  final String name;
  final String timeIn;
  final String timeOut;
  final String vehicleNo;
  final String fees;
  final Timestamp date;


  manageVehicleModel( {
    required this.name,
    required this.timeIn,
    required this.timeOut,
    required this.vehicleNo,
    required this.fees,
    required this.date,
  });

  toJason() {
    return {
      "Name": name,
      "Time In": timeIn,
      "Time Out": timeOut,
      "Vehicle No": vehicleNo,
      "Fees": fees,
      "Date": date,

    };
  }

  factory manageVehicleModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return manageVehicleModel(
        name: data["Name"],
        timeIn: data["Time In"],
        timeOut: data["Time Out"],
        vehicleNo: data["Vehicle No"],
        fees: data["Fees"],
        date: data["Date"]);
  }
}
