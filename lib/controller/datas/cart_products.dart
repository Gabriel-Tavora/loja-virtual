import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lojavirtual/controller/datas/products_data.dart';

class CartProduct {
  String? cid;
  String? category;
  String? pid;
  String? seats;
  int? quantity;
  ProductsData? productData;

  CartProduct({
    this.cid,
    this.category,
    this.pid,
    this.seats,
    this.quantity,
    this.productData,
  });

  CartProduct.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    cid = doc.id;
    category = data["category"];
    pid = data["pid"];
    seats = data["seats"];
    quantity = data["quantity"];

    if (data["product"] != null) {
      productData = ProductsData.fromMap(
        data["product"] as Map<String, dynamic>,
      );
    }
  }

  Map<String, dynamic> toCartMap() {
    return {
      "category": category,
      "pid": pid,
      "seats": seats,
      "quantity": quantity,
      "product": productData?.toResumeMap(),
    };
  }
}
