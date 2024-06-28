import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:FindMySpot/constants/text_strings.dart';
import 'package:FindMySpot/controller/dashboardController.dart';
import 'package:FindMySpot/controller/updateFeeController.dart';
import 'package:FindMySpot/model/orderScannerModel.dart';
import 'package:FindMySpot/model/updateFeeModel.dart';
import 'package:FindMySpot/utils/Regex/regex.dart';
import 'package:FindMySpot/views/categories/categories.dart';

import '../../constants/colors.dart';
import '../../constants/image_strings.dart';
import '../../utils/commonWidgets/CustomtextField.dart';

class dashboard extends StatefulWidget {
  const dashboard({Key? key}) : super(key: key);

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  final _formKey = GlobalKey<FormState>();
  dashboardController _dashboardController = Get.put(dashboardController());
  // updateFeeController _updateFeeController = Get.put(updateFeeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: false,
      extendBody: false,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 120),
        child: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: PrimaryColor,
          elevation: 25,
          disabledElevation: 20,
          onPressed: () {
            showModalBottomSheet(
              backgroundColor: Colors.white.withOpacity(1),
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0))),
              builder: (context) => Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(addYourScanner,
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 40,
                        ),
                        CustomTextField(
                          label: scannerId,
                          placeholder: tempScannerId,
                          icon: Icons.document_scanner_outlined,
                          secureText: false,
                          controller: _dashboardController.ScannerIdController,
                          type: TextInputType.number,
                          validator: (val) {
                            if (val!.isValidScannerId == false)
                              return 'Enter valid 6 digit Scanner ID';
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _dashboardController.addScanner(_dashboardController.ScannerIdController.text);

                                // updateFeeModel fee = updateFeeModel(bike: "0", car: "0");
                                // _updateFeeController.updateFee(fee);
                              }
                            },
                            child: Text(
                              add.toUpperCase(),
                              style: const TextStyle(color: Colors.white),
                            ),
                            style:
                                ElevatedButton.styleFrom(primary: SecondaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Image.asset(
              dashboardBackground,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 220),
            child: Align(
                alignment: Alignment.topCenter,
                child: MaterialButton(
                  onPressed: () {
                    showModalBottomSheet(
                        backgroundColor: Colors.white.withOpacity(1),
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0))),
                        builder: (context) => Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: SingleChildScrollView(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.8,
                              padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(orderYourScanner,
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold)),
                                  orderScannerForm(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                  },
                  color: Colors.white,
                  child: const Text('Click to Order'), 
                )),
          )
        ],
      ),
    );
  }

  Container orderScannerForm() {
    final List<String> paymentMethods = [
      'easypaisa',
      'jazzcash',
      'Debit/Credit Card'
    ];
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              label: phone,
              placeholder: tempPhone,
              icon: Icons.phone,
              secureText: false,
              controller: _dashboardController.phoneNoController,
              type: TextInputType.number,
              validator: (val) {
                if (val!.isValidPhone == false)
                  return 'Enter valid Phone Number';
              },
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              label: shipmentAddress,
              placeholder: "Address",
              icon: Icons.home,
              secureText: false,
              controller: _dashboardController.shipAddressController,
              type: TextInputType.text,
              validator: (val) {
                if (val!.isNull == true) return 'Enter Address';
              },
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              label: implementedLocation,
              placeholder: "Address",
              icon: Icons.local_parking_outlined,
              secureText: false,
              controller: _dashboardController.implementedLocationController,
              type: TextInputType.text,
              validator: (val) {
                if (val!.isNull == true) return 'Enter valid Location';
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(right: 200),
              child: Text(
                'Payment Method',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: SecondaryColor,
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField(
              value:
                  _dashboardController.paymentMethodController.text.isNotEmpty
                      ? _dashboardController.paymentMethodController.text
                      : null,
              items: paymentMethods
                  .map((type) =>
                      DropdownMenuItem(child: Text(type), value: type))
                  .toList(),
              onChanged: (value) {
                _dashboardController.paymentMethodController.text = value!;
              },
              decoration: InputDecoration(
                hintText: 'JazzCash',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
              ),
              validator: (value) {
                if (value == null) {
                  return 'Select vehicle Type';
                }
              },
            ),
            SizedBox(height: 25),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if(await _dashboardController.checkScannerExists() == false){
                      Random random = Random();
                      String id = (random.nextInt(900000) + 100000).toString();
                      final orderdetail = orderScannerModel(
                          orderStatus: "Order Confirmed",
                          phoneNo: _dashboardController.phoneNoController.text,
                          shipAddress:  _dashboardController.shipAddressController.text,
                          implementedlocation:  _dashboardController.implementedLocationController.text,
                          paymentMethod:  _dashboardController.paymentMethodController.text, scannerId: id);
                        _dashboardController.OrderScanner(orderdetail).whenComplete(() =>
                        {setState(() {})});
                    }else{
                      Get.snackbar("Error", "You Already Order your Scanner",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: PrimaryColor,
                          colorText: Colors.black);
                    }

                  }
                },
                child: Text(
                  orderNow.toUpperCase(),
                  style: const TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(primary: SecondaryColor),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
