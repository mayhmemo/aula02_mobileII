import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todo_refatoracao_baguncado/core/network/http_client.dart';

class HttpClientImpl implements HttpClient {
  final http.Client _client;

  HttpClientImpl([http.Client? client]) : _client = client ?? http.Client();

  @override
  Future<HttpResponse> get(Uri url, {Map<String, String>? headers}) async {
    final response = await _client.get(url, headers: headers);
    return _map(response);
  }

  @override
  Future<HttpResponse> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    final response = await _client.post(
      url,
      headers: headers,
      body: body,
      encoding: encoding,
    );
    return _map(response);
  }

  @override
  Future<HttpResponse> patch(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    final response = await _client.patch(
      url,
      headers: headers,
      body: body,
      encoding: encoding,
    );
    return _map(response);
  }

  @override
  Future<HttpResponse> delete(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    final response = await _client.delete(
      url,
      headers: headers,
      body: body,
      encoding: encoding,
    );
    return _map(response);
  }

  HttpResponse _map(http.Response response) {
    return HttpResponse(
      statusCode: response.statusCode,
      body: response.body,
      headers: response.headers,
    );
  }
}
