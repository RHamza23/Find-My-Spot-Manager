import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:FindMySpot/controller/sighnUpController.dart';

import '../model/manageVehicleModel.dart';

class manageVehicleController extends GetxController {
  static manageVehicleController get instance => Get.find();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;


  Future<List<manageVehicleModel>> getDataFromBikesForSelectedDateAndSearchQuery(
      DateTime? selectedDate, String searchString) async {
    if(searchString.isNotEmpty){
      final snapshot = await FirebaseFirestore.instance
          .collection('Parking Manager')
          .doc(signUpController().getCurrentUserUid())
          .collection('Bikes')
          .where('Vehicle No', isGreaterThanOrEqualTo: searchString)
          .where('Vehicle No', isLessThan: searchString + '\uf8ff')
          .get();
      final userdata =
      snapshot.docs.map((e) => manageVehicleModel.fromSnapshot(e)).toList();
      return userdata;
    }
    else if (selectedDate == null) {
      final snapshot = await _firebaseFirestore
          .collection('Parking Manager')
          .doc(signUpController().getCurrentUserUid())
          .collection('Bikes')
          .get();

      final userdata =
      snapshot.docs.map((e) => manageVehicleModel.fromSnapshot(e)).toList();
      return userdata;
    } else {

      // Create a DateTime object with time set to 00:00:00
      DateTime startDateTime = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);

      // Create a DateTime object with time set to 23:59:59
      DateTime endDateTime = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 23, 59, 59);

      // Convert the DateTime objects to Firestore Timestamps
      Timestamp startTimestamp = Timestamp.fromDate(startDateTime);
      Timestamp endTimestamp = Timestamp.fromDate(endDateTime);


      // Timestamp selectedTimestamp = Timestamp.fromDate(date!);

      final snapshot = await FirebaseFirestore.instance
          .collection('Parking Manager')
          .doc(signUpController().getCurrentUserUid())
          .collection('Bikes')
          .where('Date', isGreaterThanOrEqualTo: startTimestamp)
          .where('Date', isLessThanOrEqualTo: endTimestamp)
          .get();

      final userdata =
      snapshot.docs.map((e) => manageVehicleModel.fromSnapshot(e)).toList();
      return userdata;
    }


  }



  Future<List<manageVehicleModel>> getDataFromCarsForSelectedDateAndSearchQuery(
      DateTime? selectedDate, String searchString) async {
    if (searchString.isNotEmpty) {
      final snapshot = await FirebaseFirestore.instance
          .collection('Parking Manager')
          .doc(signUpController().getCurrentUserUid())
          .collection('Cars')
          .where('Vehicle No', isGreaterThanOrEqualTo: searchString)
          .where('Vehicle No', isLessThan: searchString + '\uf8ff')
          .get();
      final userdata =
      snapshot.docs.map((e) => manageVehicleModel.fromSnapshot(e)).toList();
      return userdata;
    }else if(selectedDate == null){
      final snapshot = await _firebaseFirestore
          .collection('Parking Manager')
          .doc(signUpController().getCurrentUserUid())
          .collection('Cars')
          .get();
      final userdata =
      snapshot.docs.map((e) => manageVehicleModel.fromSnapshot(e)).toList();
      return userdata;
    } else {

      // Create a DateTime object with time set to 00:00:00
      DateTime startDateTime = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);

      // Create a DateTime object with time set to 23:59:59
      DateTime endDateTime = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 23, 59, 59);

      // Convert the DateTime objects to Firestore Timestamps
      Timestamp startTimestamp = Timestamp.fromDate(startDateTime);
      Timestamp endTimestamp = Timestamp.fromDate(endDateTime);


      // Timestamp selectedTimestamp = Timestamp.fromDate(date!);

      final snapshot = await FirebaseFirestore.instance
          .collection('Parking Manager')
          .doc(signUpController().getCurrentUserUid())
          .collection('Cars')
          .where('Date', isGreaterThanOrEqualTo: startTimestamp)
          .where('Date', isLessThanOrEqualTo: endTimestamp)
          .get();

      final userdata =
      snapshot.docs.map((e) => manageVehicleModel.fromSnapshot(e)).toList();
      return userdata;
    }


  }


}
