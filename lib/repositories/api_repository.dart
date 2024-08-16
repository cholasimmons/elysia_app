import 'dart:convert';
import 'dart:io';

import 'package:elysia_app/constants/constants.dart';
import 'package:elysia_app/models/response_model.dart';
import 'package:elysia_app/services/toast_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ApiRepository {
  final String baseUrl = AppConstants.baseUrl;

  // Token
  final _storage = const FlutterSecureStorage();
  String? _token;

  ApiRepository() {
    loadToken();
  }

  // Load token from storage when app starts or user logs in
  Future<void> loadToken() async {
    _token = await _storage.read(key: 'lucia_auth_token');
  }

  // Common headers
  Map<String, String> _buildHeaders([bool isForm = false]) {
    return {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Credentials': 'true',
      'Access-Control-Allow-Headers': 'Content-Type',
      'Access-Control-Allow-Methods': 'GET,PUT,POST,PATCH,DELETE',
      'Content-Type': isForm ? 'multipart/form-data' : 'application/json',
      'Authentication-Method': 'JWT',
      'Accept': 'application/json, application/xml, */*;q=0.8',
      if (_token != null) 'Authorization': 'Bearer $_token',
      'ipCountry': 'Zambia'
      // Add OS, Device-Name, Brand, IP and ipCountry
    };
  }

  // GET
  Future<ApiResponse<T>> fetchData<T>(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');

    try {
      final response = await http
          .get(url, headers: _buildHeaders())
          .timeout(const Duration(seconds: AppConstants.fetchTimeout));

      final jsonData = json.decode(response.body);

      return ApiResponse.fromJson(jsonData);
    } catch(e) {
      const String res = 'Could not get data: ${AppConstants.baseUrl}';
      ToastService().showToast(kDebugMode ? e.toString() : res);
      throw Exception(res);
    }
  }

  // POST
  Future<ApiResponse> postData<T>(String endpoint, T data,
      [bool isForm = false]) async {
    final url = Uri.parse('$baseUrl$endpoint');

    try{
      final response = await http.post(
        url,
        headers: _buildHeaders(isForm),
        body: jsonEncode(data),
      ).timeout(const Duration(seconds: AppConstants.fetchTimeout));

      final jsonData = json.decode(response.body);

      return ApiResponse.fromJson(jsonData);
    } catch(e) {
      const String res = 'Could not post data}';
      ToastService().showToast(kDebugMode ? e.toString() : res);
      throw Exception(e);
    }
  }

  // PATCH
  Future<ApiResponse<T>> updateData<T>(String endpoint, int id, T data,
      [bool isForm = false]) async {
    final url = Uri.parse('$baseUrl$endpoint/$id');

    try {
      final response = await http.patch(
            url,
            headers: _buildHeaders(isForm),
            body: jsonEncode(data),
          )
          .timeout(const Duration(seconds: AppConstants.fetchTimeout));

      final jsonData = json.decode(response.body);

      return ApiResponse.fromJson(jsonData);
    } catch(e) {
      ToastService().showToast('Could not post data');
      throw Exception(e);
    }
  }

  // DELETE
  Future<ApiResponse> deleteData(String endpoint, String id,
      [bool isForm = false]) async {
    final url = Uri.parse('$baseUrl$endpoint/$id');

    try {
      final response = await http
          .patch(url, headers: _buildHeaders(isForm))
          .timeout(const Duration(seconds: AppConstants.fetchTimeout));

      final jsonData = json.decode(response.body);

      return ApiResponse.fromJson(jsonData);
    } catch(e) {
      ToastService().showToast('Could not post data');
      throw Exception(e);
    }
  }

  Future<void> sendData(String endpoint, File? file) async {
    final url = Uri.parse('$baseUrl$endpoint');

    final headers = _buildHeaders(file != null);

    if (file != null) {
      final request = http.MultipartRequest('POST', url)
        ..headers.addAll(headers)
        ..files.add(
          await http.MultipartFile.fromPath(
            'file',
            file.path,
          ),
        );

      // Send the request
      final response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (kDebugMode) {
          print('Multipart file uploaded successfully.');
        }
      } else {
        if (kDebugMode) {
          print('Failed to upload file. Status code: ${response.statusCode}');
        }
      }
    } else {
      // Fallback to normal JSON POST request
      final response = await http.post(
        url,
        headers: headers,
        body: '{"file": "$file"}',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        if (kDebugMode) {
          print(
              'Failed to send JSON data. Status code: ${response.statusCode}');
        }
      }
    }
  }
}
