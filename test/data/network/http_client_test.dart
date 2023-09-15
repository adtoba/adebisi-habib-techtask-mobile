import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tech_task/data/network/http_client.dart';
import 'package:tech_task/domain/constants/endpoints.dart';


// Test for http_client

void main() {
  group("CustomHttpClient", () {
    group("GET request", () {
      test("works as expected", () async {
        final httpClient = CustomHttpClient();
        expect(httpClient.http, isNotNull);

        var requestOptions = RequestOptions(
          baseUrl: ApiEndpoints.baseUrl,
          path: ApiEndpoints.ingredients,
          contentType: "application/json",
          method: "GET",
          sendTimeout: Duration(seconds: 30),
          receiveTimeout: Duration(seconds: 30)
        );

        var res = await httpClient.http.fetch(requestOptions);
        expect(res.statusCode, HttpStatus.ok);
        expect(res.requestOptions.method, "GET");
      });
    });
  });
}