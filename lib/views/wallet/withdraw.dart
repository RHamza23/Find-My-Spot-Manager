import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:FindMySpot/views/wallet/wallet.dart';
import '../../constants/colors.dart';
import '../../constants/image_strings.dart';
import '../../constants/text_strings.dart';
import '../../controller/walletController.dart';
import '../../model/walletModel.dart';

class withdrawMoney extends StatefulWidget {
  const withdrawMoney({Key? key}) : super(key: key);

  @override
  State<withdrawMoney> createState() => _withdrawMoneyState();
}

class _withdrawMoneyState extends State<withdrawMoney> {
  final controller = Get.put(walletController());

  String creditDepit = "Credit/Debit";
  String easypaisa = "Easypaisa";
  String jazzCash = "Jazzcash";
  String? depositMethod;
  TextEditingController withdrawAmountcontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SingleChildScrollView(
        child: Stack(children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(),
            child: Image.asset(
              blueBackground,
              color: PrimaryColor,
            ),
          ),
          Column(
            children: [
              const Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: 140),
                  child: Text(
                    withdraw,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 60,
                        color: Colors.white,
                        fontFamily: 'Lobster'),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                withdrawAmount,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Amount';
                      }
                      return null;
                    },
                    controller: withdrawAmountcontroller,
                    decoration: InputDecoration(

                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1.5, color: Colors.white), //<-- SEE HERE
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 1.5,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(15.0),),
                      hintText: "     Rs: ",
                      hintStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    // textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 25, color: Colors.white),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Padding(
                padding: EdgeInsets.only(right: 130),
                child: Text(
                  "Deposit Method:",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Column(
                  children: [
                    ListTileTheme(
                      horizontalTitleGap: 0,
                      child: RadioListTile(
                        activeColor: Colors.white,
                        title: Container(
                          alignment: Alignment.centerLeft,
                          width:  MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                          color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(width: 1, color: Colors.black)
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: const Row(
                            children: [
                              Icon(Icons.card_giftcard, color: PrimaryColor,),
                              SizedBox(width: 5,),
                              Text('Credit/Debit Card'),
                            ],
                          ),
                        ),
                        value: creditDepit,
                        groupValue: depositMethod,
                        onChanged: (value) {
                          setState(() {
                            depositMethod = value.toString();
                          });
                        },
                      ),
                    ),
                    ListTileTheme(
                      horizontalTitleGap: 0,
                      child: RadioListTile(
                        activeColor: Colors.white,
                        title: Container(
                          alignment: Alignment.centerLeft,
                          width:  MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                          color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(width: 1, color: Colors.black)
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: const Row(
                            children: [
                              Icon(Icons.card_giftcard, color: PrimaryColor,),
                              SizedBox(width: 5,),
                              Text('Easypaisa'),
                            ],
                          ),
                        ),
                        value: easypaisa,
                        groupValue: depositMethod,
                        onChanged: (value) {
                          setState(() {
                            depositMethod = value.toString();
                          });
                        },
                      ),
                    ),
                    ListTileTheme(
                      horizontalTitleGap: 0,
                      child: RadioListTile(
                        activeColor: Colors.white,
                        title: Container(
                          alignment: Alignment.centerLeft,
                          width:  MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                          color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(width: 1, color: Colors.black)
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: const Row(
                            children: [
                              Icon(Icons.card_giftcard, color: PrimaryColor,),
                              SizedBox(width: 5,),
                              Text('JazzCash'),
                            ],
                          ),
                        ),
                        value: jazzCash,
                        groupValue: depositMethod,
                        onChanged: (value) {
                          setState(() {
                            depositMethod = value.toString();
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              // Text('Selected radio button: $depositMethod'),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate() &&
                          depositMethod != null) {
                        final Id = await controller.generateId();
                        print(Id);
                        final withdraw = walletModel(
                          amount: withdrawAmountcontroller.text,
                          withdrawMethod: depositMethod!,
                          transectionId: Id,
                        );

                        double amount = double.parse(withdrawAmountcontroller.text);

                        if (await controller.getBalance() <= 0 || await controller.getBalance() < amount) {
                          Get.snackbar("Error", "You don't have enough balance in You wallet",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: PrimaryColor,
                              colorText: Colors.black);
                        } else {
                          // Perform the withdrawal logic here
                          controller.withdrawtMoney(withdraw).then((value) => {
                            controller
                                .updateBalance(
                                withdrawAmountcontroller.text.trim())
                                .then((value) => {Get.to(wallet())})
                          });
                        }

                      } else {
                        Get.snackbar("Error",
                            "Please Select an Option and Enter some Text",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: PrimaryColor,
                            colorText: Colors.black);
                      }
                    },
                    child: const Text(
                      deposit,
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(primary: SecondaryColor),
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
