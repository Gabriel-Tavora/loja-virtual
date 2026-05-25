import 'package:flutter/material.dart';
import 'package:lojavirtual/models/widgets/custom_drawer.dart';
import 'package:lojavirtual/view/pages/home_tab.dart';
import 'package:lojavirtual/view/pages/products_page.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Scaffold(
          body: HomeTab(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Produtos"),
            centerTitle: true,
            backgroundColor: const Color(0xFFC7E9FF),
            
          ),
          drawer: CustomDrawer(_pageController),
          body: ProductsPage(),
        ),
      ],
    );
  }
}
