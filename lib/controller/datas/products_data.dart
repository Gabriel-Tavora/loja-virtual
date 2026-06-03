import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsData {
  String? id;
  String? title;
  String? description;
  String? images;
  int? price;
  List<dynamic>? seats;

  ProductsData();

  ProductsData.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.id;
    title = snapshot['title'];
    description = snapshot['description'];
    price = snapshot['price'];
    seats = snapshot['seats'];
    images = snapshot['image'];
  }

  ProductsData.fromMap(Map<String, dynamic> data) {
    title = data['title'];
    description = data['description'];
    price = data['price'];
    images = data['image'];
  }

  Map<String, dynamic> toResumeMap() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'image': images,
    };
  }
}
