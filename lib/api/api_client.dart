import 'package:dio/dio.dart';
import 'package:gallery_app/api/constants/api.dart';

class ApiClient {
  static const String baseUrl = Api.baseUrl;
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: <String, dynamic>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
    ),
  );

  ApiClient() {
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  // Method to make GET requests
  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? data,
    Options? options,
  }) async {
    return await _dio.get(endpoint, queryParameters: data, options: options);
  }

  // Method to make POST requests
  Future<Response> post<T>(
    String endpoint, {
    T? data,
    Options? options,
  }) async {
    return await _dio.post(endpoint, data: data, options: options);
  }

  // Method to make PUT requests
  Future<Response> put<T>(
    String endpoint, {
    T? data,
    Options? options,
  }) async {
    return await _dio.put(endpoint, data: data, options: options);
  }

  // Method to make DELETE requests
  Future<Response> delete(String endpoint, {Map<String, dynamic>? data}) async {
    return await _dio.delete(endpoint, queryParameters: data);
  }
}
