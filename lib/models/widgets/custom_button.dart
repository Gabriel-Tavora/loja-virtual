import 'package:flutter/material.dart';
import 'package:lojavirtual/models/widgets/custom_text.dart';

class CustomButtom extends StatelessWidget {
  const CustomButtom({
    super.key,
    required this.onPressed, required this.textform,
  });
  final String textform;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            const Color.fromARGB(255, 4, 125, 141),
          ),
        ),
        child: CustomText(
          textform: textform,
          fontsize: 18,
          colortype: Colors.white,
        ),
      ),
    );
  }
}
