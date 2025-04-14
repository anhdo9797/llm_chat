import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';

/// Service xử lý API requests
class ApiService extends GetxService {
  late final dio.Dio _dio;

  // Base URL của API
  final String baseUrl = 'https://kazoku.tnmdeploy.xyz';
  final String token = 'app-26T9waZlq3qqntMPL0w6tQve';

  /// Khởi tạo ApiService
  Future<ApiService> init() async {
    _dio = dio.Dio(
      dio.BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        // Headers mặc định
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer app-26T9waZlq3qqntMPL0w6tQve',
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
    // TODO: Thêm auth token nếu cần
    handler.next(options);
  }

  // Response interceptor
  void _onResponse(
    dio.Response response,
    dio.ResponseInterceptorHandler handler,
  ) {
    handler.next(response);
  }

  // Error interceptor
  void _onError(dio.DioException err, dio.ErrorInterceptorHandler handler) {
    // TODO: Xử lý error chung
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
