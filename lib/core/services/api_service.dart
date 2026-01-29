import 'package:dio/dio.dart';
// ignore: implementation_imports
import 'package:pretty_dio_logger/src/pretty_dio_logger.dart';

import 'package:sukientotapp/core/utils/env_config.dart';
import 'package:sukientotapp/core/services/localstorage_service.dart';

class ApiService {
  late Dio _dio;

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
          final token = StorageService.readData(key: LocalStorageKeys.token);
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
