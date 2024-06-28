import 'package:FindMySpot/model/updateFeeModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../constants/image_strings.dart';
import '../../constants/text_strings.dart';
import '../../controller/updateFeeController.dart';
import '../../utils/commonWidgets/CustomtextField.dart';

class updateFee extends StatefulWidget {
  const updateFee({Key? key}) : super(key: key);

  @override
  State<updateFee> createState() => _updateFeeState();
}

class _updateFeeState extends State<updateFee> {
  updateFeeController _updateFeeController = Get.put(updateFeeController());

  final _formKey = GlobalKey<FormState>();
  final List<String> vehicleTypes = ['Car', 'Bike'];

  TextEditingController amountController = TextEditingController();
  TextEditingController bikeController = TextEditingController();
  TextEditingController carController = TextEditingController();

  updateFeeModel fee = updateFeeModel(bike: "", car: "");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }

  Future get() async {
    fee = await _updateFeeController.getFeeDetails();

    bikeController.text = fee.bike;
    carController.text = fee.car;

    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Image.asset(
                requestFormCurves,
                color: PrimaryColor,
                height: 150,
                width: 150,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            updateVehicleFee,
                            style: TextStyle(
                              fontSize: 50,
                              color: SecondaryColor,
                              height: 1.105263157894737,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          label: "Bike",
                          secureText: false,
                          type: TextInputType.number,
                          controller: bikeController,
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(

                          label: "Car",
                          secureText: false,
                          type: TextInputType.number,
                          controller: carController,
                        ),
                        const SizedBox(height: 60),
                        SizedBox(
                          height: 60,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                updateFeeModel fee = updateFeeModel(
                                    bike: bikeController.text, car: carController.text);
                                await _updateFeeController.updateFeeRecord(fee);
                              }
                            },
                            child: Text(
                              update.toUpperCase(),
                              style: const TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: SecondaryColor),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
