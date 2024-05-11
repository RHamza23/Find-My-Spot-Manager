import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../constants/image_strings.dart';
import '../../views/profile/setting.dart';

Widget FloatingActionButtonWithNotched  ()  {
  return FloatingActionButton(

    heroTag: null,
      onPressed: () {},
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: FloatingActionButton(
            backgroundColor: PrimaryColor,
            hoverElevation: 10,
            foregroundColor: Colors.black54,
            elevation: 4,
            child:SvgPicture.asset(personIcon),
            onPressed: () {
              Get.to(setting());
            }
        ),
      ),);
}