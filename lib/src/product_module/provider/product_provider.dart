import 'dart:developer';

import 'package:flutter_test_myeg/src/product_module/model/product_model.dart';

import '../repository/product_repository.dart';

class ProductProvider extends ProductRepository {
  List<ProductModel> _productModel = [];
  List<ProductModel> get productModel => _productModel;

  final ProductModel _selectedProductCategory = ProductModel();

  Future<void> fetchProductIndexProvider() async {
    setLoading(true);
    try {
      final List<ProductModel> productModelResponse =
          await fetchProductIndexRepository(
              productCategory:
                  _selectedProductCategory.category.toString().toLowerCase());
      _productModel = productModelResponse;
    } catch (e) {
      log(e.toString());
    } finally {
      notifyListeners();
      setLoading(false);
    }
  }

  Future<void> setProductCategory(int selectedIndex) async {
    bool isSelected = _productCategory[selectedIndex].value ?? false;
    _productCategory[selectedIndex].value = !isSelected;

    if (isSelected) {
      await fetchProductIndexProvider();
      await setProductFilteredCategory(selectedProductCategory: '');
    } else {
      _selectedProductCategory.category =
          _productCategory[selectedIndex].category;
      await setProductFilteredCategory(
          selectedProductCategory:
              _productCategory[selectedIndex].category.toString());
    }
    notifyListeners();
  }

  Future<void> setProductFilteredCategory(
      {String? selectedProductCategory}) async {
    if (selectedProductCategory.toString().isNotEmpty) {
      for (var element in _productCategory) {
        element.value = element.category == selectedProductCategory;
      }
      await fetchProductIndexProvider();
    } else {
      for (var element in _productCategory) {
        element.value = false;
      }
    }
    _selectedProductCategory.category = '';
    notifyListeners();
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
}
