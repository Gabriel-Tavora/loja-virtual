import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({super.key, required this.textform, required this.fontsize, required this.colortype});
final String textform;
final double fontsize;
final Color colortype;
  @override
  Widget build(BuildContext context) {
    return Text(
          textform,
          style: TextStyle(
            fontSize: fontsize,
            color: colortype,
          ),
        );
  }
}