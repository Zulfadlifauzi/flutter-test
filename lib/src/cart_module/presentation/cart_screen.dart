import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../product_module/provider/product_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: ChangeNotifierProvider(
        create: (_) => ProductProvider()..readProductCartProvider(),
        child: Consumer<ProductProvider>(
          builder: (context, value, _) {
            if (value.getProductCart.isEmpty) {
              return const Center(
                  child: Text(
                'No items in the cart',
                style: TextStyle(color: Colors.grey),
              ));
            } else {
              return ListView.builder(
                itemCount: value.getProductCart.length,
                itemBuilder: (context, index) {
                  final product = value.getProductCart[index];
                  return Card(
                    color: Colors.white,
                    child: ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.network(
                          product.image ?? '',
                          width: 70,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        product.title ?? 'No title',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14),
                      ),
                      subtitle: Row(
                        children: [
                          Text(
                            'RM ${product.price}',
                            style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                          const Spacer(),
                          IconButton(
                              style: IconButton.styleFrom(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                minimumSize: const Size(0, 0),
                              ),
                              onPressed: () {
                                value.removeQuantityProductProvider(index);
                              },
                              icon: const Icon(
                                Icons.remove_circle_outline_outlined,
                                size: 20,
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(product.quantity.toString()),
                          const SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            style: IconButton.styleFrom(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              minimumSize: const Size(0, 0),
                            ),
                            icon: const Icon(
                              Icons.add_circle_outline_outlined,
                              size: 20,
                            ),
                            onPressed: () {
                              value.addQuantityProductProvider(index);
                            },
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete_outline_outlined,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          value.removeProductCartProvider(index);
                        },
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
