import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_futurama/backend/server_response.dart';

class SharedWebService {
  static const _BASE_URL = 'https://api.sampleapis.com/futurama';

  final HttpClient _client = HttpClient();
  final Duration _timeoutDuration = const Duration(seconds: 120);
  static SharedWebService? _instance;

  SharedWebService._();

  static SharedWebService instance() {
    _instance ??= SharedWebService._();
    return _instance!;
  }

  Future<HttpClientResponse> _responseFrom(Future<HttpClientRequest> Function(Uri) toCall,
          {required Uri uri, Map<String, dynamic>? body, Map<String, String>? headers}) =>
      toCall(uri).then((request) async {
        if (headers != null) {}

        if (headers != null) headers.forEach((key, value) => request.headers.add(key, value));
        if (request.method == 'GET') {
          request.headers.contentType = ContentType('application', 'json', charset: 'utf-8');
        }
        if ((request.method == 'POST' || request.method == 'PUT' || request.method == 'PATCH') && body != null) {
          request.headers.contentType = ContentType('application', 'json', charset: 'utf-8');
          request.add(utf8.encode(json.encode(body)));
        }
        return request.close();
      }).timeout(_timeoutDuration);

  Future<HttpClientResponse> _get(Uri uri, [Map<String, String>? headers]) => _responseFrom(_client.getUrl, uri: uri, headers: headers);

  Future<List<InfoModel>> getHome() async {
    final res = await _get(Uri.parse('$_BASE_URL/info'));
    final responseBody = await res.transform(utf8.decoder).join();
    final parseResponse = jsonDecode(responseBody);

    return compute(parserAllInfo, parseResponse);
  }

  Future<List<CharactersModel>> getCharacters() async {
    final res = await _get(Uri.parse('$_BASE_URL/characters'));
    final responseBody = await res.transform(utf8.decoder).join();
    final parseResponse = jsonDecode(responseBody);

    return compute(parserAllCharacters, parseResponse);
  }
}
