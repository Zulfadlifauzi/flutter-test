import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_test_myeg/src/product_module/model/product_model.dart';

import '../repository/product_repository.dart';

class ProductProvider extends ProductRepository {
  List<ProductModel> _productModel = [];
  List<ProductModel> get productModel => _productModel;

  final TextEditingController _setSearchController = TextEditingController();
  TextEditingController get getSearchController => _setSearchController;

  final ProductModel _selectedProductCategory = ProductModel();

  Future<void> fetchProductIndexProvider() async {
    try {
      setLoading(true);
      List<ProductModel> productModelResponse =
          await fetchProductIndexRepository(
              productCategory:
                  _selectedProductCategory.category.toString().toLowerCase());

      _productModel = productModelResponse.where((item) {
        return item.title?.toLowerCase().contains(_setSearchController.text) ??
            false;
      }).toList();
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

  final List<ProductModel> _productCategory = [
    ProductModel(category: 'Electronics', value: false),
    ProductModel(category: "Men's clothing", value: false),
    ProductModel(category: 'Jewelery', value: false),
    ProductModel(category: "Women's clothing", value: false),
  ];
  List<ProductModel> get getProductCategory => _productCategory;

  Future<void> searchProductProvider(String query) async {
    _setSearchController.text = query;
    await fetchProductIndexProvider();
    notifyListeners();
  }

  Future<void> clearSearchControllerProvider() async {
    _setSearchController.clear();
    await fetchProductIndexProvider();
    notifyListeners();
  }
}
