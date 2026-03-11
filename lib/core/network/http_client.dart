import 'dart:convert';

class HttpResponse {
  final int statusCode;
  final String body;
  final Map<String, String> headers;

  HttpResponse({
    required this.statusCode,
    this.body = '',
    Map<String, String>? headers,
  }) : headers = Map.unmodifiable(headers ?? {});
}

abstract class HttpClient {
  Future<HttpResponse> get(Uri url, {Map<String, String>? headers});
  Future<HttpResponse> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  });
  Future<HttpResponse> patch(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  });
  Future<HttpResponse> delete(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  });
}
