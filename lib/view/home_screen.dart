import 'package:flutter/material.dart';
import 'package:lojavirtual/view/pages/home_tab.dart';
class home_screen extends StatelessWidget {
 home_screen({super.key});

  final _pageController = PageController();

  @override

  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        HomeTab(),


    ],
    );
  }
}
