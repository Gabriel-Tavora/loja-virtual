import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/view/pages/category_screen.dart';

class ProductsTiles extends StatelessWidget {
  const ProductsTiles({
    super.key,
    required this.doc,
  });

  final QueryDocumentSnapshot doc;

  @override
  Widget build(BuildContext context) {
    final data = doc.data() as Map<String, dynamic>;

    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(
          data["icon"],
        ),
      ),
      title: Text(
        data["title"],
      ),
      trailing: const Icon(
        Icons.keyboard_arrow_right,
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>CategoryScreen(doc: doc))
        );
      },
    );
  }
}
