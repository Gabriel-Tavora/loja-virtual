import 'package:flutter/material.dart';
import 'package:lojavirtual/models/widgets/custom_text.dart';

class CustomFlatButtom extends StatelessWidget {
  const CustomFlatButtom(
      {super.key, required this.textform, required this.onPressed});
  final String textform;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            padding: WidgetStatePropertyAll(EdgeInsets.zero),
            alignment: Alignment.topRight),
        onPressed: onPressed,
        child: CustomText(
          textform: textform,
          fontsize: 15,
          colortype: Colors.black87,
        ));
  }
}
