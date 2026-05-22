import 'package:flutter/material.dart';
import 'package:lojavirtual/models/widgets/custom_drawer.dart';
import 'package:lojavirtual/view/pages/home_produtos.dart';
import 'package:lojavirtual/view/pages/home_tab.dart';

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
            
          ),
          drawer: CustomDrawer(_pageController),
          body: HomeProdutos(),
        ),
      ],
    );
  }
}
