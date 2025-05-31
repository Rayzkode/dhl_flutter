import 'dart:convert';

import 'package:http/http.dart' as http;

class CallApi {
  final String _url="http://192.168.1.19:8000/api/";

  Future<http.Response> postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    var response = await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );

    return response;
  }
}

Map<String, String> _setHeaders() => {
  'Content-type': 'application/json',
  'Accept': 'application/json',
};