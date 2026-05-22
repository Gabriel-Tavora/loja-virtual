import 'package:flutter/material.dart';

class BuilderBody extends StatefulWidget {
  final Color color1;
  final Color color2;

  const BuilderBody({
    super.key,
    required this.color1,
    required this.color2,
  });

  @override
  State<BuilderBody> createState() => _BuilderBodyState();
}

class _BuilderBodyState extends State<BuilderBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            widget.color1,
            widget.color2,
          ],
        ),
      ),
    );
  }
}