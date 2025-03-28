import 'package:dio/dio.dart';
import 'package:flutter_test_myeg/data/provider/base_provider.dart';

class DioServices extends BaseProvider {
  final Dio dio = Dio();
}
