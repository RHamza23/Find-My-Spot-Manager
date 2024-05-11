import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inparkmanager/utils/Regex/regex.dart';
import '../../constants/colors.dart';
import '../../constants/image_strings.dart';
import '../../constants/text_strings.dart';
import '../../controller/profileController.dart';
import '../../controller/sighnUpController.dart';
import '../../model/UserModel.dart';
import '../../model/orderScannerModel.dart';
import '../../utils/commonWidgets/CustomtextField.dart';
import '../../utils/commonWidgets/headerText.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  final controller = Get.put(signUpController());
  final _profileController = Get.put(profileController());

  static GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  File? _imageFile;
  String? _imageUrl;

  String? ImageUrlFromFirebase;

    userModel user=userModel(name: "", email: "", phone: "", password: "");

  TextEditingController Email = TextEditingController();
  TextEditingController Fullname = TextEditingController();
  TextEditingController Password = TextEditingController();
  TextEditingController PhoneNo = TextEditingController();
  TextEditingController Location = TextEditingController();


  Future _pickImage() async {
    final pickedFile =
    await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = File(pickedFile!.path);
    });

    final url = await _profileController.uploadImageAndGetLink(_imageFile!);
    setState(() {
      _imageUrl = url;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }

  Future get() async
  {
    user= await _profileController.getUserDetails();
    orderScannerModel location =  await _profileController.getUserLocationFromhisOrder();

    Email.text=user.email;
    Fullname.text=user.name;
    Password.text=user.password;
    PhoneNo.text=user.phone;
    Location.text = location.implementedlocation!;
    setState(() {
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
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
      backgroundColor: PrimaryColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                height: MediaQuery.of(context).size.height ,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(),
                child: Image.asset(
                  whiteBackground,
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        // _openGallery();
                        _pickImage();
                      },
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[700],
                          border: Border.all(
                              color: Colors.white,
                              width: 5.0,
                              style: BorderStyle.solid),
                        ),
                        child: FutureBuilder(
                          future: _profileController.getUserDetails(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.done) {
                              if (snapshot.hasData) {
                                userModel userData = snapshot.data as userModel;
                                if (userData.profileImage != null && userData.profileImage!.isNotEmpty) {
                                  return ClipOval(
                                    child: Image.network(
                                      userData.profileImage!,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                } else {
                                  // Show person icon or placeholder when image data is empty
                                  return ClipOval(
                                    child: SvgPicture.asset(personIcon)
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
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Column(
                    children: [
                      ProfileForm(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget ProfileForm() {
    // return Container(
    // child: FutureBuilder(
    //     builder: (context, snapshot) {

    if(user!=null)
    {
      return Container(
        child: Column(
            children:[

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: Fullname,
                      label: name,
                      // placeholder: userData.name,
                      icon: Icons.person_outline_rounded,
                      secureText: false,
                      type: TextInputType.text,
                      validator: (val) {
                        if (val!.isValidName == false) {
                          return 'Enter valid Name';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: Email,
                      label: email,
                      icon: Icons.email_outlined,
                      secureText: false,
                      type: TextInputType.emailAddress,
                      validator: (val) {
                        if (val!.isValidEmail == false) {
                          return 'Enter valid email';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: PhoneNo,
                      label: phone,
                      icon: Icons.numbers,
                      secureText: false,
                      type: TextInputType.phone,
                      validator: (val) {
                        if (val!.isValidPhone == false) {
                          return 'Enter valid Phone';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      disableTextField: false,
                      controller: Location,
                      label: location,
                      icon: Icons.location_city,
                      secureText: false,
                      type: TextInputType.text,
                      // validator: (val) {
                      //   if (val!.isEmpty == false) {
                      //     return 'Enter Address';
                      //   }
                      // },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: Password,
                      label: password,
                      icon: Icons.password,
                      secureText: false,
                      type: TextInputType.text,
                      validator: (val) {
                        if (controller.password
                            .toString()
                            .isEmpty) {
                          return 'Please enter some text';
                        }
                        if (val!.isValidPassword == false) {
                          return ' Password should contain A,a ,123';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width/2,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // Update user data in Firebase Firestore
                            final userData = userModel(
                              id: signUpController.instance.getCurrentUserUid().toString(),
                              name: Fullname.text.trim(),
                              email: Email.text.trim(),
                              phone: PhoneNo.text.trim(),
                              password: Password.text.trim(),
                              location:Location.text.trim(),
                              profileImage: user.profileImage.toString(),
                            );
                            await _profileController.updateUserRecord(userData);
                          }
                          setState(() {});
                        },
                        style:
                        ElevatedButton.styleFrom(primary: SecondaryColor),
                        child: Text(
                          update.toUpperCase(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),]
        ),
      );

    }
    else {
      return const Center(child: CircularProgressIndicator(),);
    }
  }
}
