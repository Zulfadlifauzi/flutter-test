import 'package:flutter/material.dart';

import '../../../data/utils/debounce_utils.dart';
import '../provider/product_provider.dart';

class ProductIndexSearchComponents extends StatelessWidget {
  final ProductProvider productProviderInstance;
  const ProductIndexSearchComponents(
      {super.key, required this.productProviderInstance});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        autocorrect: false,
        controller: productProviderInstance.getSearchController,
        onChanged: (String values) {
          DebounceUtils.startDebounceTimer(() async {
            await productProviderInstance.searchProductProvider(values);
          });
        },
        decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Colors.grey[100],
            filled: true,
            hintText: 'Search name of product...',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: productProviderInstance
                    .getSearchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      productProviderInstance.clearSearchControllerProvider();
                    },
                  )
                : const SizedBox()),
      ),
    );
  }
}
