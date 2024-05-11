import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:inparkmanager/controller/dashboardController.dart';
import 'package:inparkmanager/views/categories/categories.dart';

import '../../views/Dashboard/dashboard.dart';
import '../../views/welcomeScreen/welcomeScreen.dart';


class AuthenticationRepository extends GetxController{
  static  AuthenticationRepository get instance => Get.find();
  final dashboardController _dashboardController = Get.put(dashboardController()) ;
  //variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) async {
    // user == null ? Get.offAll(() => WelcomeScreen()) : Get.offAll(() => const dashboard());
    if ( user == null){
      Get.offAll(() => WelcomeScreen());
    }else if(await _dashboardController.checkScannerExistInManagerAccount() == false){
    Get.offAll(() => const dashboard());
    }else{
      Get.offAll(() => const categories());
    }
  }

}

