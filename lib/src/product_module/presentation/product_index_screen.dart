import 'package:flutter/material.dart';
import 'package:flutter_test_myeg/src/cart_module/presentation/cart_screen.dart';
import 'package:flutter_test_myeg/src/product_module/provider/product_provider.dart';
import 'package:provider/provider.dart';

import '../components/product_index_category_components.dart';
import '../components/product_index_data_components.dart';

class ProductIndexScreen extends StatelessWidget {
  const ProductIndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductProvider()..fetchProductIndexProvider(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Consumer<ProductProvider>(builder: (context, value, _) {
              value.readProductCartProvider();
              return Badge(
                offset: const Offset(-5, -2),
                label: Text(value.getProductCart.length.toString()),
                child: IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CartScreen()));
                  },
                ),
              );
            })
          ],
        ),
        body: const SafeArea(
          child: Column(
            children: [
              ProductIndexCategoryComponents(),
              ProductIndexDataComponents()
            ],
          ),
        ),
      ),
    );
  }
}
