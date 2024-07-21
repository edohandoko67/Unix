import 'package:dio/dio.dart';

class DioClient {
  Dio? _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://mocki.io/v1/e5092fdb-acbf-4631-a10d-389e62639a7b', // Example mock API base URL
        connectTimeout: 5000,
        receiveTimeout: 3000,
      ),
    );
  }

  Dio get dio => _dio!;
}