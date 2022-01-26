import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:linkati/src/services/urls.dart';

import '../../main.dart';
import 'app_exceptions.dart';

class BaseClient {
  static const int TIME_OUT_DURATION = 20;
  // static var token = "db96aeb1ce123c114a97f17f9e9b555297abb808";
  Map<String, String> headers = {
    if (prefs!.getString('token') != null)
      "Authorization": "Token ${prefs!.getString('token')}",
    "Content-Type": "application/json",
  };

  // GET
  Future<dynamic> get({
    required String api,
  }) async {
    var uri = Uri.parse(MAIN_URL + api);

    try {
      var response = await http
          .get(uri, headers: headers)
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  // POST
  Future<dynamic> post(String api, dynamic payloadObj) async {
    var uri = Uri.parse(MAIN_URL + api);
    var payload = json.encode(payloadObj);

    try {
      var response = await http
          .post(uri, headers: headers, body: payload)
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  // UPDATE
  Future<dynamic> put(String api, dynamic payloadObj) async {
    var uri = Uri.parse(MAIN_URL + api);
    var payload = json.encode(payloadObj);

    print(payload);

    try {
      var response = await http
          .put(uri, headers: headers, body: payload)
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  // DELETE
  Future<dynamic> delete(String api) async {
    var uri = Uri.parse(MAIN_URL + api);

    try {
      var response = await http
          .delete(uri, headers: headers)
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  // OTHER

  // Process Response
  static dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var jsonResponse = utf8.decode(response.bodyBytes);
        if (jsonResponse.isEmpty) {
          throw FetchDataException(
              "No Data response", response.request!.url.toString());
        }
        return jsonResponse;
      case 400:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 401:
        throw FetchDataException(
            "Error! Your account has been restricted from access",
            response.request!.url.toString());
      case 403:
        throw UnAuthorizedException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 404:
        throw FetchDataException("Error! There is no website with this domain",
            response.request!.url.toString());
      default:
        throw FetchDataException(
            "Error occured with code : ${response.statusCode}",
            response.request!.url.toString());
    }
  }
}
