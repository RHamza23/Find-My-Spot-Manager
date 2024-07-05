import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:FindMySpot/constants/colors.dart';
import '../../constants/image_strings.dart';
import '../../constants/text_strings.dart';
import '../../controller/Repositories/authentication_repository.dart';
import '../welcomeScreen/welcomeScreen.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 5),
      () {
        Get.put(AuthenticationRepository());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SvgPicture.asset(
                SplashImage,
                width: 200,
                height: 200,
              ),
            ),
            const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const Text(
              from,
              style: TextStyle(
                fontFamily: 'Roboto-Medium',
                fontSize: 17,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const Text(
              findMySpot,
              style: TextStyle(
                fontFamily: 'Lobster',
                fontSize: 25,
                color: PrimaryColor,
                height: 0.4,
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
