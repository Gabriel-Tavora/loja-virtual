import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/controller/datas/products_data.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({
    super.key,
    required this.product,
  });

  final ProductsData product;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFC7E9FF),
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
                items: product.seats!.map((url) {
                  return Image.network(
                    url.toString(),
                    fit: BoxFit.cover,
                    width: double.infinity,
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    product.title!,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                  Text(
                    "R\$ ${product.price}",
                    style: TextStyle(
                      fontSize: 23,
                      color: Colors.teal.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Assentos",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 34,
                    child: GridView(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      scrollDirection: Axis.horizontal,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8,
                       childAspectRatio: 0.5,
                    ),
                    children: product.seats!.map((s){
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          border: Border.all(
                            color: Colors.grey.shade500
                          ),
                        ),
                        width: 50,
                        alignment: Alignment.center,
                        child: Text(s),
                      );
                    }).toList(),),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
