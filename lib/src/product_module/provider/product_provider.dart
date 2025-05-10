import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_test_myeg/src/product_module/model/product_model.dart';

import '../../../data/utils/shared_preferences_utils.dart';
import '../repository/product_repository.dart';

class ProductProvider extends ProductRepository {
  List<ProductModel> _productModel = [];
  List<ProductModel> get getProductModel => _productModel;

  List<ProductModel> _productCart = [];
  List<ProductModel> get getProductCart => _productCart;

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

  Future<void> addProductToCartProvider(
    ProductModel productModelData,
  ) async {
    try {
      final List<Map<String, dynamic>> existingCart =
          await SharedPreferencesMixin.readListMapSharedPreferences('product');

      List<Map<String, dynamic>> cartList =
          existingCart.cast<Map<String, dynamic>>();

      bool isProductInCartExist = false;
      for (var item in cartList) {
        if (item['id'] == productModelData.id) {
          item['quantity'] = (item['quantity'] ?? 0) + 1;
          isProductInCartExist = true;
          break;
        }
      }

      if (!isProductInCartExist) {
        productModelData.quantity = 1;
        cartList.add(productModelData.toJson());
      }

      await SharedPreferencesMixin.saveListMapSharedPreferences(
          'product', cartList);

      _productCart =
          cartList.map((json) => ProductModel.fromJson(json)).toList();

      notifyListeners();
    } catch (e) {
      log('Error adding product to cart: $e');
    }
  }

  Future<void> readProductCartProvider() async {
    try {
      final List<Map<String, dynamic>> existingCart =
          await SharedPreferencesMixin.readListMapSharedPreferences('product');

      _productCart = existingCart.map<ProductModel>((json) {
        return ProductModel.fromJson(json);
      }).toList();

      notifyListeners();
    } catch (e) {
      log('Error reading product cart: $e');
    }
  }

  Future<void> addQuantityProductProvider(int index) async {
    try {
      if (_productCart[index].quantity != null) {
        _productCart[index].quantity = _productCart[index].quantity! + 1;
        updateProductQuantityProvider(index);
      }
      notifyListeners();
    } catch (e) {
      log('Error adding quantity to product: $e');
    }
  }

  Future<void> removeQuantityProductProvider(int index) async {
    try {
      if (_productCart[index].quantity != null &&
          _productCart[index].quantity! > 1) {
        _productCart[index].quantity = _productCart[index].quantity! - 1;
        updateProductQuantityProvider(index);
      } else {
        await SharedPreferencesMixin.removeSingleDataMapListSharedPreferences(
            'product', index);
        _productCart.removeAt(index);
      }

      notifyListeners();
    } catch (e) {
      log('Error removing quantity from product: $e');
    }
  }

  void updateProductQuantityProvider(int index) async {
    final List<Map<String, dynamic>> existingCart =
        await SharedPreferencesMixin.readListMapSharedPreferences('product');
    existingCart[index]['quantity'] = _productCart[index].quantity;
    await SharedPreferencesMixin.saveListMapSharedPreferences(
        'product', existingCart);
  }

  Future<void> removeProductCartProvider(int index) async {
    try {
      await SharedPreferencesMixin.removeSingleDataMapListSharedPreferences(
          'product', index);
      _productCart.removeAt(index);
      notifyListeners();
    } catch (e) {
      log('Error removing product from cart: $e');
    }
  }

  int getProductQuantity(int productId) {
    final productInCart = _productCart.firstWhere(
      (cartItem) => cartItem.id == productId,
      orElse: () => ProductModel(quantity: 0),
    );
    return productInCart.quantity ?? 0;
  }
}
