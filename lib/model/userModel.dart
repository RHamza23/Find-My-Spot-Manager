import 'package:cloud_firestore/cloud_firestore.dart';

class userModel {
  final String? id;
  final String name;
  final String email;
  final String phone;
  final String password;
  final String? location;
  final String? profileImage;

  userModel(
      {this.id,
        required this.name,
        required this.email,
        required this.phone,
        required this.password,
        this.location,
        this.profileImage});

  toJason() {
    return {
      "Id": id,
      "Name": name,
      "Email": email,
      "Phone": phone,
      "Password": password,
      "Location": location,
      "ProfileImage": profileImage,
    };
  }

  factory userModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return userModel(
        id: document.id,
        name: data["Name"],
        email: data["Email"],
        phone: data["Phone"],
        password: data["Password"],
        location: data["Location"],
        profileImage: data["ProfileImage"]);
  }
}
