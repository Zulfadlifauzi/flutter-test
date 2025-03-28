import 'package:dio/dio.dart';

import '../../../data/constants/api_constants.dart';
import '../../../data/services/dio_services.dart';
import '../model/product_model.dart';

class ProductRepository extends DioServices {
  Future<List<ProductModel>> fetchProductIndexRepository() async {
    final Response response = await dio.get('${ApiConstants.baseUrl}products');
    if (response.statusCode == 200) {
      final List<dynamic> productModelResponse = response.data;
      return productModelResponse
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<ProductModel> fetchProductShowRepository(String productId) async {
    final Response response =
        await dio.get('${ApiConstants.baseUrl}products/$productId');
    if (response.statusCode == 200) {
      return ProductModel.fromJson(response.data);
    } else {
      throw Exception('Failed to load products');
    }
  }
}
