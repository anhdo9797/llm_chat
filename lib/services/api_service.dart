import 'dart:developer';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import '../core/constants/app_constants.dart';
import 'package:llm_chat/core/constants/app_constants.dart';

/// Service xử lý API requests
class ApiService extends GetxService {
  late final dio.Dio _dio;

  // Base URL và API Key từ constants
  final String baseUrl = AppConstants.baseUrl;
  late final String apiKey;

  /// Khởi tạo ApiService
  /// [apiKey]: API key để xác thực với server
  Future<ApiService> init({required String apiKey}) async {
    this.apiKey = apiKey;

    _dio = dio.Dio(
      dio.BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        // Headers mặc định
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
      ),
    );

    // Thêm interceptors
    _dio.interceptors.add(
      dio.InterceptorsWrapper(
        onRequest: _onRequest,
        onResponse: _onResponse,
        onError: _onError,
      ),
    );

    return this;
  }

  // Request interceptor
  void _onRequest(
    dio.RequestOptions options,
    dio.RequestInterceptorHandler handler,
  ) {
    // Log request URL và method
    log('REQUEST [${options.method}] ${options.uri}');

    // Log request headers
    log('Headers: ${options.headers}');

    // Log request data nếu có
    if (options.data != null) {
      log('Request Data: ${options.data}');
    }

    // Log query parameters nếu có
    if (options.queryParameters.isNotEmpty) {
      log('Query Params: ${options.queryParameters}');
    }

    handler.next(options);
  }

  // Response interceptor
  void _onResponse(
    dio.Response response,
    dio.ResponseInterceptorHandler handler,
  ) {
    // Log response code và URL
    log('RESPONSE [${response.statusCode}] ${response.requestOptions.uri}');

    // Log response data
    if (response.data != null) {
      log('Response Data: ${response.data}');
    }

    handler.next(response);
  }

  // Error interceptor
  void _onError(dio.DioException err, dio.ErrorInterceptorHandler handler) {
    // Log error message và URL
    log('ERROR [${err.response?.statusCode}] ${err.requestOptions.uri}');
    log('Error Message: ${err.message}');

    // Log error response nếu có
    if (err.response?.data != null) {
      log('Error Response: ${err.response?.data}');
    }

    handler.next(err);
  }

  /// GET request
  Future<dio.Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    dio.Options? options,
  }) async {
    try {
      return await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } on dio.DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// POST request
  Future<dio.Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    dio.Options? options,
  }) async {
    try {
      return await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on dio.DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Xử lý error
  Exception _handleError(dio.DioException error) {
    // TODO: Custom error handling
    return error;
  }

  /// Stream POST request để xử lý response dạng stream
  Stream<String> postStream(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    dio.Options? options,
  }) async* {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: dio.Options(
          responseType: dio.ResponseType.stream,
          headers: options?.headers,
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to send message');
      }

      final stream = response.data.stream as Stream;

      await for (var chunk in stream) {
        final String decodedChunk = String.fromCharCodes(chunk);
        final lines = decodedChunk.split('\n');

        for (var line in lines) {
          if (line.trim().isEmpty) continue;
          if (!line.startsWith('data: ')) continue;

          final data = line.substring(6); // Remove 'data: ' prefix
          yield data;
        }
      }
    } on dio.DioException catch (e) {
      throw _handleError(e);
    }
  }
}
