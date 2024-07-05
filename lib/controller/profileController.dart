import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:FindMySpot/controller/sighnUpController.dart';
import '../constants/colors.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import '../model/UserModel.dart';
import '../model/orderScannerModel.dart';

class profileController extends GetxController {
  static profileController get instance => Get.find();
    final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  get user => _auth.currentUser;

  final firebaseInstance = FirebaseFirestore.instance;

  // Firebase Storage Variables
  final storage = FirebaseStorage.instance;
  final firestore = FirebaseFirestore.instance;

  Future<userModel> getUserDetails() async {
    final snapshot = await _firebaseFirestore
        .collection("Parking Manager")
        .where("Id",
        isEqualTo: signUpController().getCurrentUserUid().toString())
        .get();
    final userdata = snapshot.docs.map((e) => userModel.fromSnapshot(e)).single;
    return userdata;
  }

  Future<List<userModel>> getAllUserdetail() async {
    final snapshot = await _firebaseFirestore.collection("Client").get();
    final userdata =
    snapshot.docs.map((e) => userModel.fromSnapshot(e)).toList();
    return userdata;
  }

  Future<void> updateUserRecord(userModel user) async {
    await _firebaseFirestore
        .collection("Parking Manager")
        .doc(signUpController().getCurrentUserUid().toString())
        .update(user.toJason()).whenComplete(() => {
      Get.snackbar("Success", "Your profile has been updated",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: PrimaryColor,
          colorText: Colors.white
      )
    });
  }

  Future uploadImageAndGetLink(File imageFile) async {
    if (imageFile == null) {
      return null;
    }
    // Get a reference to the Firebase Storage location where the image will be uploaded
    final Reference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('images/${DateTime.now().toString()}');

    // Upload the image to Firebase Storage
    final UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
    final TaskSnapshot downloadUrl = (await uploadTask.whenComplete(() {}));

    // Get the download URL of the image
    final String url = (await downloadUrl.ref.getDownloadURL());

    // Store the download URL of the image in Firebase Firestore
    await FirebaseFirestore.instance
        .collection("Parking Manager")
        .doc(signUpController().getCurrentUserUid().toString())
        .update({"ProfileImage": url});
    // .add({'ProfileImage': url});

    // Return the download URL of the image
    return url;
  }

  Future<orderScannerModel> getUserLocationFromhisOrder() async {
    final snapshot = await _firebaseFirestore
        .collection("Parking Manager")
        .doc(signUpController().getCurrentUserUid().toString())
        .collection("Scanners")
        .get();
    final userdata = snapshot.docs.map((e) => orderScannerModel.fromSnapshot(e)).single;
    return userdata;
  }
}
