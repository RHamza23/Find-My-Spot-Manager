import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? placeholder;
  final IconData? icon;
  final bool secureText;
  final TextEditingController? controller;
  final  TextInputType type;
  final String? Function(String?)? validator;
  String? intialValue;
  final IconButton? suffixIcon;
  bool? disableTextField;
  CustomTextField({
    required this.label,
     this.placeholder,
     this.icon,
    required this.secureText,
    this. controller,
    required this.type,
    this.validator,
    this.intialValue, this.suffixIcon,this.disableTextField,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: SecondaryColor,
              fontSize: 15,
            ),
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          enabled: disableTextField,
          initialValue: intialValue,
          validator: validator,
          controller: controller,
          obscureText: secureText,
          keyboardType: type,
          decoration: InputDecoration(
            prefixIcon: Icon(icon),
            suffixIcon: suffixIcon,
            hintText: placeholder,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ],
    );
  }
}
