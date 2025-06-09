import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:result_dart/result_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ApiBase {
  // Basepath cannot have trailing slashes & all request path should be prefixed with /
  final String basePath;
  final http.Client _client;
  String? _token;

  ApiBase({required this.basePath}) : _client = http.Client();

  AsyncResult<Object> _send(http.BaseRequest req) {
    req.headers['Content-Type'] = 'application/json';
    if (_token != null) {
      req.headers['root_auth_token'] = _token!;
    }
    return _client.send(req).then((res) => _toResponse(res)).then((res) {
      if (res.statusCode == 200) {
        return Success(jsonDecode(res.body));
      } else {
        return Failure(Exception(res.body));
      }
    });
  }

  Future<http.Response> _toResponse(http.StreamedResponse streamedResponse) async {
    final bodyBytes = await streamedResponse.stream.toBytes();
    return http.Response.bytes(
      bodyBytes,
      streamedResponse.statusCode,
      request: streamedResponse.request,
      headers: streamedResponse.headers,
      isRedirect: streamedResponse.isRedirect,
      persistentConnection: streamedResponse.persistentConnection,
      reasonPhrase: streamedResponse.reasonPhrase,
    );
  }

  AsyncResult<Object> post(String url, Map<String, dynamic> body) {
    final String path = '$basePath$url';
    final req = http.Request('POST', Uri.parse(path))..bodyBytes = utf8.encode(jsonEncode(body));
    return _send(req);
  }

  AsyncResult<Object> get(String url, Map<String, dynamic> queryParams) {
    final uri = Uri.parse(
      '$basePath$url',
    ).replace(queryParameters: queryParams.map((key, value) => MapEntry(key, value.toString())));
    final req = http.Request('GET', uri);
    return _send(req);
  }

  // setToken(String token) {
  //   _token = token;
  // }

  // void setToken(String token) async {
  //   final pref = await SharedPreferences.getInstance();
  //   await pref.setString('root_auth_token', token); // Save token to storage
  //   _token = token;
  // }
  Future<void> loadToken() async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString('token');
    _token = token;
  }

  void setToken(String token) {
    SharedPreferences.getInstance().then((pref) {
      pref.setString('token', token);
      _token = token;
    });
  }
}
