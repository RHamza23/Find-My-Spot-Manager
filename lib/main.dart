import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:FindMySpot/views/splash_Screens/SplashScreen.dart';

import 'controller/Repositories/authentication_repository.dart';
import 'firebase_options_old.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'find-my-spot-manager',
    options: DefaultFirebaseOptions.currentPlatform);
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: MaterialColor(
              0xff0425BF,
              <int, Color>{
                50: Color(0x330425BF),
                100: Color(0x330425BF),
                200: Color(0x4d0425BF),
                300: Color(0x660425BF),
                400: Color(0x800425BF),
                500: Color(0x990425BF),
                600: Color(0xb30425BF),
                700: Color(0xcc0425BF),
                800: Color(0xe60425BF),
                900: Color(0xff0425BF),
              },
            )),
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,

        home: splashScreen());
  }
}
