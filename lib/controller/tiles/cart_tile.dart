import 'package:flutter/material.dart';
import 'package:lojavirtual/controller/datas/cart_products.dart';
import 'package:lojavirtual/informations/users/cart_model.dart';
import 'package:provider/provider.dart';

class CartTile extends StatelessWidget {
  final CartProduct cartProduct;

  const CartTile({
    super.key,
    required this.cartProduct,
  });

  @override
  Widget build(BuildContext context) {
    final product = cartProduct.productData;

    if (product == null) {
      return const SizedBox.shrink();
    }

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            height: 120,
            child: Image.network(
              product.images ?? "",
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Assento: ${cartProduct.seats}",
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Qtd: ${cartProduct.quantity}",
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "R\$ ${product.price}",
                    style: TextStyle(
                      color: Colors.green.shade600,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (cartProduct.quantity != 1) {
                            context.read<CartModel>().decProduct(cartProduct);
                          }
                        },
                        icon: Icon(
                          Icons.remove,
                          color: cartProduct.quantity == 1
                              ? Colors.grey
                              : Colors.black,
                        ),
                      ),
                      Text(cartProduct.quantity.toString()),
                      IconButton(
                        onPressed: () {
                          context.read<CartModel>().incProduct(cartProduct);
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.black,
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          final removedProduct = cartProduct;

                          await context
                              .read<CartModel>()
                              .removeCartItem(removedProduct);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  const Text("Produto removido do carrinho"),
                              action: SnackBarAction(
                                label: "Desfazer",
                                onPressed: () {
                                  context
                                      .read<CartModel>()
                                      .addCartItem(removedProduct);
                                },
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        },
                        child: const Text(
                          "Remover",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
