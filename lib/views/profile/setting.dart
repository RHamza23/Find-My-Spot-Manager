import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:inparkmanager/views/profile/profile.dart';
import '../../constants/colors.dart';
import '../../constants/image_strings.dart';
import '../../constants/text_strings.dart';
import '../../controller/profileController.dart';
import '../../model/UserModel.dart';
import '../../utils/commonWidgets/CustomBottomNavigationBarWithWallet.dart';
import '../../utils/commonWidgets/FloatingactionButtonWithNotched.dart';
import '../../utils/commonWidgets/headerWidget.dart';
import '../requests/requests.dart';
import '../updateFee/updateFee.dart';
import '../userManagement/signIn.dart';
import '../wallet/wallet.dart';


class setting extends StatefulWidget {
  @override
  State<setting> createState() => _settingState();
}

class _settingState extends State<setting> {


@override
  void initState() {
      setState(() {
      });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;

    profileController _profileController = Get.put(profileController());

    return Scaffold(
        bottomNavigationBar: CustomNavigationBar1(),
        floatingActionButtonLocation:
        FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton:
        FloatingActionButtonWithNotched(),
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: PrimaryColor,
            ),
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(),
                child: Image.asset(
                  blueBackground,
                  color: PrimaryColor,
                ),
              ),
            ),
            Positioned(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height/3,
                        child: FutureBuilder(
                          future: _profileController.getUserDetails(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.done) {
                              if (snapshot.hasData) {
                                userModel userData = snapshot.data as userModel;
                                if (userData.profileImage != null && userData.profileImage!.isNotEmpty) {
                                  return Column(
                                    children: [
                                      Container(
                                        width: 150,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey[700],
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 5.0,
                                            style: BorderStyle.solid,
                                          ),
                                        ),
                                        child: ClipOval(
                                          child: Image.network(
                                            userData.profileImage!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        userData.name,
                                        style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        userData.email,
                                        style: const TextStyle(fontSize: 16, color: Colors.white),
                                      ),
                                      const SizedBox(height: 40),
                                    ],
                                  );
                                } else {
                                  // Show person icon or placeholder when image data is empty
                                  return Column(
                                    children: [
                                      Container(
                                        width: 150,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey[700],
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 5.0,
                                            style: BorderStyle.solid,
                                          ),
                                        ),
                                        child: SvgPicture.asset(personIcon)
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        userData.name,
                                        style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        userData.email,
                                        style: const TextStyle(fontSize: 16, color: Colors.white),
                                      ),
                                      const SizedBox(height: 40),
                                    ],
                                  );
                                }
                              } else if (snapshot.hasError) {
                                return const Center(child: CircularProgressIndicator());
                              } else {
                                return const Center(child: CircularProgressIndicator());
                              }
                            } else {
                              return const Center(child: CircularProgressIndicator());
                            }
                          },
                        ),

                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.to(const wallet());
                        },
                        child: const Text(
                          'MY WALLET',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 30, vertical: 13),
                          backgroundColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: 60,
                                width: 350,
                                child: IconButton(
                                    onPressed: () {
                                      Get.to(const vehicleRequests());
                                    },
                                    icon:
                                    Image.asset(acceptRequestButton))),
                            Container(
                                height: 60,
                                width: 350,
                                child: IconButton(
                                    onPressed: () {
                                      Get.to(const profile());
                                    },
                                    icon: Image.asset(editProfileButton))),
                            Container(
                                height: 60,
                                width: 350,
                                child: IconButton(
                                    onPressed: () {
                                      Get.to(const updateFee());
                                    },
                                    icon: Image.asset(feesUpdateButton))),
                            Container(
                                height: 60,
                                width: 350,
                                child: IconButton(
                                    onPressed: () {
                                      _auth
                                          .signOut()
                                          .then((value) => Get.to(const signIn()));
                                    }, icon: Image.asset(logoutButton),
                                   )),
                          ]),
                    ],
                  ),
                )),
          ],
        ));
  }
}
