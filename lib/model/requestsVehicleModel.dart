import 'package:cloud_firestore/cloud_firestore.dart';
class requestVehicleModel {
  final String? ownerName;
  final String? ownerCnic;
  final String? ownerVehicleNo;
  final String? ownerVehicleType;
  final String? parkingManagerEmail;
  final String? existingVehicle;
  final String? documentID;
  final String? status;
  final DateTime? time;

  requestVehicleModel(
      {
       this.ownerName,
       this.ownerCnic,
       this.ownerVehicleNo,
       this.ownerVehicleType,
       this.parkingManagerEmail,
       this.existingVehicle,
       this.documentID,
       this.status, this.time,
      });

  toJason() {
    return {
      "Owner Name": ownerName,
      "Owner Cnic": ownerCnic,
      "Owner Vehicle Number": ownerVehicleNo,
      "Owner Vehicle Type": ownerVehicleType,
      "Email Parking Manager": parkingManagerEmail,
      "Existing Vehicle": existingVehicle,
      "Id": documentID,
      "Status": status,
      "Time": time,
    };
  }

  factory requestVehicleModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return requestVehicleModel(
      parkingManagerEmail: data["Email Parking Manager"],
      existingVehicle: data["Existing Vehicle"],
      documentID: data["Id"],
      ownerCnic: data["Owner Cnic"],
      ownerName: data["Owner Name"],
      ownerVehicleNo: data["Owner Vehicle Number"],
      ownerVehicleType: data["Owner Vehicle Type"],
      status: data["Status"],
      time: DateTime.fromMicrosecondsSinceEpoch(data["Time"]),

    );
  }
}
