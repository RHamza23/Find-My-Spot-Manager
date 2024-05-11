
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../constants/colors.dart';
import '../model/userModel.dart';
import '../views/dashboard/dashboard.dart';
import '../views/userManagement/signUp.dart';

class  signUpController extends GetxController{

  static signUpController get instance =>  Get.find();
  //variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  final _db = FirebaseFirestore.instance;


  // TextField Controllers to get data from textfields
  final email = TextEditingController();
  final fullname = TextEditingController();
  final password = TextEditingController();
  final phoneNo = TextEditingController();

  //call the function from design and it will do the rest

  Future<void> createUserWithEmailpassword(String email , String password) async {
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      firebaseUser.value != null ? Get.to(() =>const dashboard()) : Get.to(() => signUp());
    }on FirebaseAuthException catch(e) {
    }catch (_){}
  }

  Future LoginWithEmailpassword(String email , String password) async {
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    }on FirebaseAuthException catch(e) {
    }catch (_){
      return false;
    }
  }

  Future<void> logout() async => await _auth.signOut();

  Future<void> createUser(userModel user) async {
    await _db.collection("Parking Manager").doc(getCurrentUserUid().toString()).set(user.toJason()).whenComplete(
            () => Get.snackbar("Success", "Your account has been created",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: PrimaryColor,
            colorText: Colors.black
        )
    ).catchError((error, stackTrace){
      Get.snackbar("Error", "Something went wrong. Try Again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: PrimaryColor,
          colorText: Colors.black
      );
    });
  }

  String getCurrentUserUid()  {
    final user = _auth.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      throw Exception("No signed-in user.");
    }
  }
}