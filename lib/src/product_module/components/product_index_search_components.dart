import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/utils/debounce_utils.dart';
import '../provider/product_provider.dart';

class ProductIndexSearchComponents extends StatelessWidget {
  const ProductIndexSearchComponents({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(builder: (context, value, _) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextFormField(
          autocorrect: false,
          controller: value.getSearchController,
          onChanged: (String values) {
            DebounceUtils.startDebounceTimer(() async {
              await value.searchProductProvider(values);
            });
          },
          decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: Colors.grey[100],
              filled: true,
              hintText: 'Search name of product...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: value.getSearchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        value.clearSearchControllerProvider();
                      },
                    )
                  : const SizedBox()),
        ),
      );
    });
  }
}
