import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/product_provider.dart';

class ProductIndexCategoryComponents extends StatelessWidget {
  const ProductIndexCategoryComponents({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(builder: (context, value, _) {
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
              selected: value.getProductCategory[index].value ?? false,
              onSelected: (values) {
                value.setProductCategory(index);
              },
            );
          },
        ),
      );
    });
  }
}
