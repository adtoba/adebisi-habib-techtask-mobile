import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tech_task/domain/constants/endpoints.dart';

class CustomHttpClient {
  late Dio http;

  CustomHttpClient() {
    this.http = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: Duration(seconds: 30),
        receiveTimeout: Duration(seconds: 30),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json"
        }
      )
    )..interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: ((options, handler) {
          return handler.next(options);
        }),
        onError: (e, handler) {
          return handler.next(e);
        },
        onResponse: (res, handler) {
          return handler.next(res);
        },
      )
    )..transformer = BackgroundTransformer();

    if(!kReleaseMode) {
      http.interceptors.addAll([
        PrettyDioLogger(
          request: true,
          responseBody: true,
          error: true
        )
      ]);
    }
  }
}