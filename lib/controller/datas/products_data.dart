import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsData {

  String? category;
  String? id;
  String? title;
  String? description;
  String? images;
  int? price;
  List<dynamic>? seats;
  ProductsData.fromDocument(DocumentSnapshot snapshot) {

    id = snapshot.id;
    title = snapshot['title'];
    description = snapshot['description'];
    price = snapshot['price'];
    seats = snapshot['seats'];
    images = snapshot['image'];
  }
}