
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inparkmanager/utils/Regex/regex.dart';
import 'package:inparkmanager/views/userManagement/signIn.dart';

import '../../constants/colors.dart';
import '../../constants/image_strings.dart';
import '../../constants/text_strings.dart';
import '../../controller/sighnUpController.dart';
import '../../model/userModel.dart';
import '../../utils/commonWidgets/CustomtextField.dart';
import '../../utils/commonWidgets/headerText.dart';

class signUp extends StatefulWidget {
  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: PrimaryColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.zero,
        physics: BouncingScrollPhysics(),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 40, 0, 0),
              child: headerWidget(
                title: findMySpot,
                color: Colors.white, FontSize: 60,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 180),
              child: Image.asset(
                SignUpCurve,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                fit: BoxFit.fill,
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 1.2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 200, 30, 0),
              child: Column(
                children: [CreateAccountText(), signUpFormWidget()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget CreateAccountText() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 100),
            child: Text(
              createAnAccount,
              style: TextStyle(
                fontSize: 25,
                color: SecondaryColor,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 160),
            child: Text(
              signUpToContinue,
              style: TextStyle(
                fontSize: 15,
                color: LightGreyColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container signUpFormWidget() {
    final controller = Get.put(signUpController());

    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextField(
              label: name,
              placeholder: tempName,
              icon:  Icons.person_outline_rounded,
              secureText: false,
              controller:  controller.fullname,
              type: TextInputType.text,
              validator: (val) {
                if (val!.isValidName == false)
                  return 'Enter valid Name';
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              label: email,
              placeholder: tempEmail,
              icon: Icons.email_outlined,
              secureText: false,
              controller: controller.email,
              type: TextInputType.emailAddress,
              validator: (val) {
                if (val!.isValidEmail == false)
                  return 'Enter valid email';
              },
            ),

            SizedBox(
              height: 10,
            ),
            CustomTextField(
              label: phone,
              placeholder: tempPhone,
              icon: Icons.numbers,
              secureText: false,
              controller: controller.phoneNo,
              type: TextInputType.phone,
              validator: (val) {
                if (val!.isValidPhone == false)
                  return 'Enter valid Phone';
              },
            ),

            SizedBox(
              height: 10,
            ),
            CustomTextField(
              label: password,
              placeholder: '******',
              icon: Icons.password,
              secureText: true,
              controller: controller.password,
              type:  TextInputType.text,
              validator: (val) {
                if (controller.password.toString().isEmpty ) {
                  return 'Please enter some text';
                }
                if (val!.isValidPassword == false)
                  return ' Password should contain A,a ,123';
              },
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    signUpController.instance
                        .createUserWithEmailpassword(
                        controller.email.text.toString(),
                        controller.password.text.toString())
                        .then((value) {
                      final user = userModel(
                        id: controller.getCurrentUserUid().toString(),
                        name: controller.fullname.text.trim(),
                        email: controller.email.text.trim(),
                        phone: controller.phoneNo.text.trim(),
                        password: controller.password.text.trim(),
                        location: "location",
                        profileImage: "",
                      );
                      signUpController.instance.createUser(user);
                    });
                  }
                },
                child: Text(
                  Signup.toUpperCase(),
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(primary: SecondaryColor),
              ),

            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Get.to(signIn());
              },
              child: Text(
                alreadyHaveAccount,
                style: TextStyle(
                  fontSize: 15,
                  color: LightGreyColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
