import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:FindMySpot/controller/requestController.dart';
import '../../constants/colors.dart';
import '../../constants/image_strings.dart';
import '../../model/requestsVehicleModel.dart';
import '../../utils/commonWidgets/CustomBottomNavigationBarWithWallet.dart';
import '../../utils/commonWidgets/FloatingactionButtonWithNotched.dart';

class vehicleRequests extends StatefulWidget {
  const vehicleRequests({Key? key}) : super(key: key);

  @override
  State<vehicleRequests> createState() => _vehicleRequestsState();
}

class _vehicleRequestsState extends State<vehicleRequests> {
  final requestController _requestController = Get.put(requestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      extendBodyBehindAppBar: true,
      extendBody: true,
      bottomNavigationBar: CustomNavigationBar1(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButtonWithNotched(),
      backgroundColor: PrimaryColor,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(),
              child: Image.asset(
                whiteBackground,
              ),
            ),
          ),
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 80),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Requests",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontFamily: 'Lobster'),
                  ),
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              Container(
                height: 480,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: FutureBuilder(
                      future: _requestController.getRequests(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount:  snapshot.data!.length,
                                physics: const ClampingScrollPhysics(),
                                reverse: false,
                                itemBuilder: (c, index) {
                                  final status = snapshot.data![index].status;
                                  if(status == "Approved"){
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 20),
                                      child: Stack(children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 30),
                                          child: InkWell(
                                            child: Image.asset(
                                                requestsVehicleListView,
                                                color: PrimaryColor,),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(
                                                    40, 10, 0, 0),
                                                child: Text(
                                                  'Existing'.toUpperCase(),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Roboto',
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(
                                                    40, 0, 0, 0),
                                                child: Text(
                                                  "${snapshot.data![index].existingVehicle}",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Roboto',
                                                    fontSize: 25,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(
                                                    40, 10, 0, 0),
                                                child: Text(
                                                  'Current'.toUpperCase(),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Roboto',
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(
                                                    30, 0, 0, 0),
                                                child: Text(
                                                  "  ${snapshot.data![index].ownerVehicleNo}",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Roboto',
                                                    fontSize: 25,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  0, 18, 60, 0),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Text(
                                                  "${snapshot.data![index].ownerName}",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Roboto',
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  0, 8, 60, 0),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Text(
                                                  "${snapshot.data![index].ownerCnic}",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Roboto',
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  0, 5, 70, 0),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Container(
                                                  height: 30,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: InkWell(
                                                      onTap: () {
                                                        // Add your onPressed logic here
                                                      },
                                                      child:  const Center(
                                                        child:  Icon(
                                                            Icons.task_alt_sharp,
                                                            color: Colors.green ,size: 30,),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),
                                      ]),
                                    );
                                  }else if(status == "Denied"){
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 20),
                                      child: Stack(children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 30),
                                          child: InkWell(
                                            child: Image.asset(
                                                requestsVehicleListView,
                                                    color: PrimaryColor,
                                                ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(
                                                    40, 10, 0, 0),
                                                child: Text(
                                                  'Existing'.toUpperCase(),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Roboto',
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(
                                                    40, 0, 0, 0),
                                                child: Text(
                                                  "${snapshot.data![index].existingVehicle}",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Roboto',
                                                    fontSize: 25,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(
                                                    40, 10, 0, 0),
                                                child: Text(
                                                  'Current'.toUpperCase(),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Roboto',
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(
                                                    40, 0, 0, 0),
                                                child: Text(
                                                  "${snapshot.data![index].ownerVehicleNo}",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Roboto',
                                                    fontSize: 25,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  0, 18, 60, 0),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Text(
                                                  "${snapshot.data![index].ownerName}",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Roboto',
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  0, 8, 60, 0),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Text(
                                                  "${snapshot.data![index].ownerCnic}",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Roboto',
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  0, 5, 70, 0),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Container(
                                                  height: 30,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: InkWell(
                                                      onTap: () {
                                                        // Add your onPressed logic here
                                                      },
                                                      child:  const Center(
                                                        child: Icon(
                                                          Icons.cancel_outlined,
                                                          color: Colors.red,
                                                            size: 30,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),
                                      ]),
                                    );
                                  }else {
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 20),
                                      child: Stack(children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 30),
                                          child: InkWell(
                                            child: Image.asset(
                                                requestsVehicleListView,
                                                color: PrimaryColor,),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(
                                                    40, 10, 0, 0),
                                                child: Text(
                                                  'Existing'.toUpperCase(),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Roboto',
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(
                                                    40, 0, 0, 0),
                                                child: Text(
                                                  "${snapshot.data![index].existingVehicle}",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Roboto',
                                                    fontSize: 25,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(
                                                    40, 10, 0, 0),
                                                child: Text(
                                                  'Current'.toUpperCase(),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Roboto',
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(
                                                    30, 0, 0, 0),
                                                child: Text(
                                                  "  ${snapshot.data![index].ownerVehicleNo}",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Roboto',
                                                    fontSize: 25,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  0, 18, 60, 0),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Text(
                                                  "${snapshot.data![index].ownerName}",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Roboto',
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  0, 8, 60, 0),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Text(
                                                  "${snapshot.data![index].ownerCnic}",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Roboto',
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  0, 10, 57, 0),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    height: 30,
                                                    width: 60,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    child: InkWell(
                                                      onTap: () {
                                                        // print("${snapshot.data![index].status}");
                                                        _requestController.updateStatus(snapshot.data![index].documentID.toString(), 'Approved');
                                                        setState(() {
                                                        });
                                                      },
                                                      child: const Center(
                                                        child: Icon(
                                                            Icons.task_alt_sharp,
                                                            color: Colors.green),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    height: 30,
                                                    width: 60,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    child: InkWell(
                                                      onTap: () {
                                                        _requestController.updateStatus(snapshot.data![index].documentID.toString(), 'Denied');
                                                        setState(() {
                                                        });
                                                      },
                                                      child: const Center(
                                                        child: Icon(
                                                            Icons.cancel_outlined,
                                                            color: Colors.red),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                          ],
                                        ),
                                      ]),
                                    );
                                  }
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
              )
            ],
          )
        ],
      ),
    );
  }
}
