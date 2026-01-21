import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
// ignore: implementation_imports
import 'package:pretty_dio_logger/src/pretty_dio_logger.dart';

import 'package:sukientotapp/core/env_config.dart';

class ApiService {
  late Dio _dio;
  final GetStorage _storage = GetStorage();

  static final String baseUrl = EnvConfig.apiBaseUrl;

  ApiService() {
    if (baseUrl.isEmpty || baseUrl == '') {
      throw Exception('API_BASE_URL is not set in environment variables');
    }

    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = _storage.read('token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          return handler.next(e);
        },
      ),
    );

    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        filter: (options, args) {
          //  return !options.uri.path.contains('posts');
          return !args.isResponse || !args.hasUint8ListData;
        },
      ),
    );
  }

  Dio get dio => _dio;
}
