import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsData {

  final String category;
  final String id;
  final String title;
  final String description;
  final int price;
  final List seats;

  ProductsData({
    required this.category,
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.seats,
  });

  factory ProductsData.fromDocument(
      DocumentSnapshot doc) {

    final data =
        doc.data() as Map<String, dynamic>;

    return ProductsData(

      id: doc.id,

      category: data['category'],

      title: data['title'],

      description:
          data['description'],

      price: data['price'],

      seats: data['seats'],
    );
  }
}