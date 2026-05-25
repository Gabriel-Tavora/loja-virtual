import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/controller/tiles/products_tiles.dart';
import 'package:lojavirtual/models/widgets/builderbody.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final docs = snapshot.data!.docs;

        return Stack(
          children: [
            BuilderBody(color1: Color(0xFFC7E9FF), color2: Colors.white),
            ListView.separated(
              itemCount: docs.length,
              separatorBuilder: (context, index) {
                return const Divider(
                  color: Colors.white,
                );
              },
              itemBuilder: (context, index) {
                return ProductsTiles(
                  doc: docs[index],
                );
              },
            ),
          ],
        );
      },
    );
  }
}
