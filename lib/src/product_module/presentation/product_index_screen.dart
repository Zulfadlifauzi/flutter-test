import 'package:flutter/material.dart';
import 'package:flutter_test_myeg/src/product_module/provider/product_provider.dart';
import 'package:provider/provider.dart';

import '../../cart_module/presentation/cart_screen.dart';
import '../model/product_model.dart';
import 'product_show_screen.dart';

class ProductIndexScreen extends StatelessWidget {
  const ProductIndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CartScreen()));
            },
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (_) => ProductProvider()..fetchProductIndexProvider(),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Consumer<ProductProvider>(builder: (context, value, _) {
                return SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  height: 40,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 10,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: value.getProductCategory.length,
                    itemBuilder: (context, index) {
                      return ChoiceChip(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        label: Text(
                          value.getProductCategory[index].category.toString(),
                        ),
                        selected:
                            value.getProductCategory[index].value ?? false,
                        onSelected: (values) {
                          value.setProductCategory(index);
                        },
                      );
                    },
                  ),
                );
              }),
              Consumer<ProductProvider>(
                builder: (context, value, _) {
                  if (value.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (value.productModel.isEmpty) {
                    return const Center(child: Text('No products available'));
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: value.productModel.length,
                        itemBuilder: (context, index) {
                          final ProductModel product =
                              value.productModel[index];
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                        product.image.toString(),
                                        height: 105,
                                        width: 105,
                                        fit: BoxFit.cover),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                  product.rating?.rate
                                                          .toString() ??
                                                      '',
                                                  style: const TextStyle(
                                                      fontSize: 14),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  '(${product.rating?.count.toString()})',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey),
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
            ],
          ),
        ),
      ),
    );
  }
}
