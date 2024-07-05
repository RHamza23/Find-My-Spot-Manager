import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:FindMySpot/constants/colors.dart';
import '../../constants/image_strings.dart';
import '../../constants/text_strings.dart';
import '../../controller/profileController.dart';
import '../../controller/walletController.dart';
import '../../model/UserModel.dart';
import '../../utils/commonWidgets/CustomBottomNavigationBarWithWallet.dart';
import '../../utils/commonWidgets/FloatingactionButtonWithNotched.dart';
import 'withdraw.dart';

class wallet extends StatefulWidget {
  const wallet({Key? key}) : super(key: key);

  @override
  State<wallet> createState() => _walletState();
}

class _walletState extends State<wallet> {
  profileController _profileController = Get.put(profileController());
  walletController _walletController = Get.put(walletController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PrimaryColor,
      floatingActionButtonLocation:
      FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButtonWithNotched(),
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
            color: Colors.white,
          ),
        ),
      ),
      extendBody: true,
      bottomNavigationBar: CustomNavigationBar1(null),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Container(
              height: MediaQuery.of(context).size.height ,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(),
              child: Image.asset(
                whiteBackground,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 90, 0, 0),
            child: Column(children: [
              FutureBuilder(
                future: _profileController.getUserDetails(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      userModel userData = snapshot.data as userModel;
                      return Align(
                        alignment: Alignment.center,
                        child: Column(children: [
                          Text(
                            userData.name,
                            style: const TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 25,
                              color: Colors.white,
                              letterSpacing: 4,
                              fontWeight: FontWeight.w700,
                              height: 0.625,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            userData.email,
                            style: const TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 15,
                              color: Colors.white,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w700,
                              height: 0.625,
                            ),
                          ),
                          const SizedBox(
                            height: 80,
                          ),
                          Container(
                            height: 126,
                            width: 240,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: PrimaryColor,
                            ),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                const Text(
                                  balance,
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 18,
                                    color: Colors.white,
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.w700,
                                    height: 0.625,
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                FutureBuilder(
                                    future: _walletController.getBalance(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        if (snapshot.hasData) {
                                          // balanceModel balanceData = snapshot.data as balanceModel;
                                          return  Text(
                                            'RS: ${snapshot.data}',
                                            style: const TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 25,
                                              color: Colors.white,
                                              letterSpacing: 2,
                                              fontWeight: FontWeight.w700,
                                              height: 0.625,
                                            ),
                                          );
                                        } else if (snapshot.hasError) {
                                          return Center(
                                            child: Text(
                                                snapshot.error.toString()),
                                          );
                                        } else {
                                          return const Center(
                                            child:
                                            Text("Something went Wrong"),
                                          );
                                        }
                                      } else {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    }),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                    height: 30,
                                    width: 120,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Get.to(const withdrawMoney());
                                        },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white
                                    ),
                                        child:   Text(
                                          withdraw.toUpperCase(),
                                          textAlign: TextAlign.center,
                                          style:
                                          const  TextStyle(color: Colors.black),
                                        ),
                                    )
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20,),
                          const Text(
                            'LATEST TRANSACTIONS',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 20,
                              color: PrimaryColor,
                              fontWeight: FontWeight.w500,
                              height: 1.12,
                            ),
                            textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                            softWrap: false,
                          ),
                          const SizedBox(height: 30,),

                          SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Container(
                              height: 300,
                              width: MediaQuery.of(context).size.width,
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: FutureBuilder(
                                    future: _walletController.getTransections(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        if (snapshot.hasData) {
                                          return ListView.builder(
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              itemCount: snapshot.data!.length,
                                              physics: const ClampingScrollPhysics(),
                                              reverse: true,
                                              itemBuilder: (c, index) {
                                                return Padding(
                                                  padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  child: Column(
                                                    children: [
                                                      ListTile(
                                                        title:  Text(
                                                            "Bank Transfer - ${snapshot.data![index].withdrawMethod }"),
                                                        subtitle: const Text(
                                                            "Payment Sent"),
                                                        textColor: Colors.black,
                                                        leading: const Icon(
                                                          Icons
                                                              .circle_notifications_sharp,
                                                          color: PrimaryColor,
                                                          size: 40,
                                                        ),
                                                        trailing:  Text(
                                                          "Rs: ${snapshot.data![index].amount}",
                                                          style: const TextStyle(
                                                              fontSize: 20),
                                                        ),
                                                        shape:
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              15),

                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      )
                                                    ],
                                                  ),
                                                );
                                              });
                                        } else if (snapshot.hasError) {
                                          return Center(
                                            child: Text(snapshot.error.toString()),
                                          );
                                        } else {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      } else {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    }),
                              ),
                            ),
                          ),
                        ]),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else {
                      return const Center(
                        child: Text("Something went Wrong"),
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ]),
          )
        ],
      ),
    );
  }
}

