import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/controller/datas/cart_products.dart';
import 'package:lojavirtual/controller/datas/products_data.dart';
import 'package:lojavirtual/informations/users/cart_model.dart';
import 'package:lojavirtual/informations/users/user_type.dart';
import 'package:lojavirtual/view/pages/cart_screen.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({
    super.key,
    required this.product,
  });
  final ProductsData product;
  final String size = "";
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int? size;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 4, 125, 141),
        centerTitle: true,
        title: Text(product.title ?? ""),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 0.9,
            child: CarouselSlider(
              options: CarouselOptions(
                height: 300,
                autoPlay: false,
                enlargeCenterPage: true,
              ),
              items: [
                Image.network(
                  product.images ?? "",
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  product.title ?? "",
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                Text(
                  "R\$ ${product.price}",
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.teal.shade600,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Assentos",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 34,
                  child: GridView(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.5,
                    ),
                    children: product.seats!.map((s) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            size = s;
                          });
                        },
                        child: Container(
                          width: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: s == size
                                  ? Colors.blue
                                  : Colors.grey.shade500,
                              width: 3,
                            ),
                          ),
                          child: Text(
                            s.toString(),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                ElevatedButton(
                  onPressed: size == null
                      ? null
                      : () async {
                          final user = context.read<UserType>();

                          if (!user.isLoggedIn) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Faça login para adicionar ao carrinho"),
                              ),
                            );
                            return;
                          }

                          final cartProduct = CartProduct(
                            pid: product.id,
                            quantity: 1,
                            seats: size.toString(),
                            productData: product,
                          );

                          await context
                              .read<CartModel>()
                              .addCartItem(cartProduct);

                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Produto adicionado ao carrinho"),
                                backgroundColor: Colors.green,
                              ),
                            );
                          }
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => CartScreen(),
                            ),
                          );
                        },
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Color.fromARGB(255, 4, 125, 141),
                    ),
                  ),
                  child: const Text(
                    "Adicionar ao Carrinho",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text("Descrição",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black)),
                Text("${product.description}",
                    style: TextStyle(fontSize: 16, color: Colors.black))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
