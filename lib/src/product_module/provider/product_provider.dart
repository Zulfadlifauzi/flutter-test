import 'dart:developer';

import 'package:flutter_test_myeg/src/product_module/model/product_model.dart';

import '../repository/product_repository.dart';

class ProductProvider extends ProductRepository {
  List<ProductModel> _productModel = [];
  List<ProductModel> get productModel => _productModel;

  Future<void> fetchProductIndexProvider() async {
    setLoading(true);
    try {
      final List<ProductModel> productModelResponse =
          await fetchProductIndexRepository();
      _productModel = productModelResponse;
    } catch (e) {
      log(e.toString());
    } finally {
      notifyListeners();
      setLoading(false);
    }
  }

  ProductModel _productShowModel = ProductModel();
  ProductModel get productShowModel => _productShowModel;

  Future<void> fetchProductShowProvider(String productId) async {
    setLoading(true);
    try {
      final ProductModel productModelShowResponse =
          await fetchProductShowRepository(productId);
      _productShowModel = productModelShowResponse;
    } catch (e) {
      log(e.toString());
    } finally {
      notifyListeners();
      setLoading(false);
    }
  }
}
