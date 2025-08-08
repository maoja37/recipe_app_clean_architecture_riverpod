// lib/core/network/network_service.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:recipe_huto_test/core/errors/failures.dart';

enum RequestMethod { get, post, put, patch, delete }

abstract interface class NetworkProvider {
  Future<Response?> call({
    required String path,
    required RequestMethod method,
    dynamic body = const {},
    Options? options,
    Map<String, dynamic> queryParams = const {},
  });
}

class NetworkProviderImpl extends NetworkProvider {
  Future<Dio> _dio({Map<String, dynamic>? headers}) async {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 30),
        headers: headers,
      ),
    );

    if (kDebugMode) {
      // Pretty Dio logger is a Dio interceptor that logs network calls in
      // a pretty, easy to read format.
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
      );
    }

    return dio;
  }

  @override
  Future<Response?> call({
    required String path,
    required RequestMethod method,
    body = const {},
    Options? options,
    Map<String, dynamic> queryParams = const {},
  }) async {
    try {
      final dio = await _dio(headers: options?.headers);

      return switch (method) {
        RequestMethod.get => await dio.get(path, queryParameters: queryParams),
        RequestMethod.post => await dio.post(
          path,
          data: body,
          queryParameters: queryParams,
          options: options,
        ),
        RequestMethod.patch => await dio.patch(
          path,
          data: body,
          queryParameters: queryParams,
        ),
        RequestMethod.put => await dio.put(
          path,
          data: body,
          queryParameters: queryParams,
        ),
        RequestMethod.delete => await dio.delete(
          path,
          data: body,
          queryParameters: queryParams,
        ),
      };
    } catch (e) {
      if (e is ServerFailure) rethrow;
      throw NetworkFailure();
    }
  }
}
