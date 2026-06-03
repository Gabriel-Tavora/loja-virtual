import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/controller/datas/cart_products.dart';
import 'package:lojavirtual/informations/users/user_type.dart';

class CartModel extends ChangeNotifier {
  UserType? userType;

  List<CartProduct> products = [];

  CartModel(this.userType);

  void updateUser(UserType user) {
    userType = user;

    if (user.firebaseUser != null) {
      loadCartItems();
    } else {
      products.clear();
      notifyListeners();
    }
  }

  Future<void> loadCartItems() async {
    if (userType?.firebaseUser == null) return;

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(userType!.firebaseUser!.uid)
        .collection("cart")
        .get();

    products =
        snapshot.docs.map((doc) => CartProduct.fromDocument(doc)).toList();

    notifyListeners();
  }

  Future<void> addCartItem(CartProduct cartProduct) async {
    try {
      final existingProduct = products.firstWhere(
        (p) => p.pid == cartProduct.pid && p.seats == cartProduct.seats,
        orElse: () => CartProduct(),
      );

      if (existingProduct.pid != null) {
        existingProduct.quantity =
            (existingProduct.quantity ?? 0) + (cartProduct.quantity ?? 1);

        if (userType?.firebaseUser != null && existingProduct.cid != null) {
          await FirebaseFirestore.instance
              .collection("users")
              .doc(userType!.firebaseUser!.uid)
              .collection("cart")
              .doc(existingProduct.cid)
              .update({
            "quantity": existingProduct.quantity,
          });
        }
      } else {
        products.add(cartProduct);

        if (userType?.firebaseUser != null) {
          DocumentReference docCart = await FirebaseFirestore.instance
              .collection("users")
              .doc(userType!.firebaseUser!.uid)
              .collection("cart")
              .add(cartProduct.toCartMap());

          cartProduct.cid = docCart.id;
        }
      }

      notifyListeners();
    } catch (e) {
      debugPrint("Erro ao adicionar item: $e");
    }
  }

  Future<void> removeCartItem(CartProduct cartProduct) async {
    try {
      products.remove(cartProduct);

      if (userType?.firebaseUser != null && cartProduct.cid != null) {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(userType!.firebaseUser!.uid)
            .collection("cart")
            .doc(cartProduct.cid)
            .delete();
      }

      notifyListeners();
    } catch (e) {
      debugPrint("Erro ao remover item: $e");
    }
  }

  Future<void> incProduct(CartProduct cartProduct) async {
    cartProduct.quantity = (cartProduct.quantity ?? 0) + 1;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(userType!.firebaseUser!.uid)
        .collection("cart")
        .doc(cartProduct.cid)
        .update({
      "quantity": cartProduct.quantity,
    });

    notifyListeners();
  }

  Future<void> decProduct(CartProduct cartProduct) async {
    if ((cartProduct.quantity ?? 0) <= 1) {
      await removeCartItem(cartProduct);
      return;
    }

    cartProduct.quantity = cartProduct.quantity! - 1;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(userType!.firebaseUser!.uid)
        .collection("cart")
        .doc(cartProduct.cid)
        .update({
      "quantity": cartProduct.quantity,
    });

    notifyListeners();
  }

  Future<void> signOut() async {
    products.clear();
    notifyListeners();
  }

  double get productsPrice {
    double price = 0;

    for (CartProduct c in products) {
      if (c.productData != null) {
        price += c.quantity! * c.productData!.price!;
      }
    }

    return price;
  }
}
