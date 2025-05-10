import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/product_model.dart';
import '../presentation/product_show_screen.dart';
import '../provider/product_provider.dart';

class ProductIndexDataComponents extends StatelessWidget {
  const ProductIndexDataComponents({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<ProductProvider>(
        builder: (context, value, _) {
          if (value.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (value.getProductModel.isEmpty) {
            return const Center(child: Text('No products available'));
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                await value.fetchProductIndexProvider();
                await value.readProductCartProvider();
              },
              child: ListView.builder(
                itemCount: value.getProductModel.length,
                itemBuilder: (context, index) {
                  final ProductModel product = value.getProductModel[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductShowScreen(
                                    productId: product.id.toString(),
                                  )));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(product.image.toString(),
                                height: 105, width: 105, fit: BoxFit.cover),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        product.title.toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 20,
                                        ),
                                        Text(
                                          product.rating?.rate.toString() ?? '',
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '(${product.rating?.count.toString()})',
                                          style: const TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'RM ${product.price.toString()}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  product.description.toString(),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        style: IconButton.styleFrom(
                                          padding: const EdgeInsets.only(
                                              top: 10, bottom: 10),
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          minimumSize: const Size(0, 0),
                                        ),
                                        onPressed: () {
                                          value.removeQuantityProductProvider(
                                              index);
                                        },
                                        icon: const Icon(
                                          Icons.remove_circle_outline_outlined,
                                          size: 20,
                                        )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(value
                                        .getProductQuantity(product.id!)
                                        .toString()),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    IconButton(
                                      style: IconButton.styleFrom(
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        minimumSize: const Size(0, 0),
                                      ),
                                      icon: const Icon(
                                        Icons.add_circle_outline_outlined,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        value.addProductToCartProvider(
                                            value.getProductModel[index]);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
