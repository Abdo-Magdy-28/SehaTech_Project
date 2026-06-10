// ── health_matrix_service.dart ────────────────────────────────────────────────

import 'dart:convert';
import 'package:grad_project/models/healthmatrixmodel.dart';
import 'package:http/http.dart' as http;

class HealthMatrixService {
  static const String _baseUrl = 'https://sehatech-backend-gilt.vercel.app';

  // ── POST /api/medicalInfo/:userId  (create) ──────────────────────────────────

  Future<HealthMatrixModel> createHealthMatrix({
    required String userId,
    required String token,
    required HealthMatrixModel data,
  }) async {
    final uri = Uri.parse('$_baseUrl/api/medicalInfo/$userId');
    final response = await http.post(
      uri,
      headers: _headers(token),
      body: jsonEncode(data.toJson()),
    );
    _checkStatus(response, 'createHealthMatrix');
    return _parseResponse(response, 'createHealthMatrix');
  }

  // ── GET /api/medicalInfo/:userId  (read) ─────────────────────────────────────

  Future<HealthMatrixModel> getHealthMatrix({
    required String userId,
    required String token,
  }) async {
    final uri = Uri.parse('$_baseUrl/api/medicalInfo/$userId');
    final response = await http.get(uri, headers: _headers(token));
    _checkStatus(response, 'getHealthMatrix');
    return _parseResponse(response, 'getHealthMatrix');
  }

  // ── PATCH /api/medicalInfo/:userId  (update) ─────────────────────────────────

  Future<HealthMatrixModel> updateHealthMatrix({
    required String userId,
    required String token,
    required HealthMatrixModel data,
  }) async {
    final uri = Uri.parse('$_baseUrl/api/medicalInfo/$userId');
    final response = await http.patch(
      uri,
      headers: _headers(token),
      body: jsonEncode(data.toJson()),
    );
    _checkStatus(response, 'updateHealthMatrix');
    return _parseResponse(response, 'updateHealthMatrix');
  }

  // ── Helpers ──────────────────────────────────────────────────────────────────

  Map<String, String> _headers(String token) => {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };

  /// Safely decodes and parses the response body.
  /// Throws [HealthMatrixException] if JSON is invalid or shape is unexpected.
  HealthMatrixModel _parseResponse(http.Response response, String caller) {
    final Map<String, dynamic> body;
    try {
      body = jsonDecode(response.body) as Map<String, dynamic>;
    } catch (_) {
      throw HealthMatrixException(
        statusCode: response.statusCode,
        message: '[$caller] Response is not valid JSON',
      );
    }
    try {
      return HealthMatrixModel.fromJson(body);
    } catch (e) {
      throw HealthMatrixException(
        statusCode: response.statusCode,
        message: '[$caller] Unexpected response shape: $e',
      );
    }
  }

  void _checkStatus(http.Response response, String caller) {
    if (response.statusCode == 401) {
      throw HealthMatrixException(
        statusCode: 401,
        message: 'Session expired. Please log in again.',
      );
    }
    if (response.statusCode < 200 || response.statusCode >= 300) {
      String message = 'Request failed';
      try {
        final body = jsonDecode(response.body) as Map<String, dynamic>;
        message =
            body['message'] as String? ?? body['error'] as String? ?? message;
      } catch (_) {}
      throw HealthMatrixException(
        statusCode: response.statusCode,
        message: '[$caller] $message',
      );
    }
  }
}

class HealthMatrixException implements Exception {
  final int statusCode;
  final String message;

  HealthMatrixException({required this.statusCode, required this.message});

  @override
  String toString() => 'HealthMatrixException($statusCode): $message';
}
