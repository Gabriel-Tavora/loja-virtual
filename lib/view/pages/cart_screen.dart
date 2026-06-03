import 'package:flutter/material.dart';
import 'package:lojavirtual/controller/tiles/cart_tile.dart';
import 'package:lojavirtual/informations/users/cart_model.dart';
import 'package:lojavirtual/models/widgets/custom_text.dart';
import 'package:lojavirtual/view/pages/home_screen.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen( {super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          textform: "Meu Carrinho",
          fontsize: 25,
          colortype: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFC7E9FF),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => HomeScreen(),
                ),
              );
            },
            icon: Icon(Icons.arrow_back)),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              child: Text("itens"),
            ),
          )
        ],
      ),
      body: Consumer<CartModel>(
        builder: (context, cart, child) {
          if (cart.products.isEmpty) {
            return const Center(
              child: Text(
                "Carrinho vazio",
                style: TextStyle(fontSize: 20),
              ),
            );
          }

          return ListView.builder(
            itemCount: cart.products.length,
            itemBuilder: (context, index) {
              return CartTile(
                cartProduct: cart.products[index],
              );
            },
          );
        },
      ),
    );
  }
}
