import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';
import 'package:http/http.dart' as http;

const String _baseUrl =
    'https://8080-dep-01kp3cxxfzs0chgwd41w54zmem-d.cloudspaces.litng.ai';

Map<String, String> get _headers => {
  'Authorization': 'Bearer $drugApiToken',
  'Content-Type': 'application/json',
};

class DrugInteractionService {
  Future<List<String>> autocomplete(String query) async {
    if (query.trim().isEmpty) return [];

    final uri = Uri.parse(
      '$_baseUrl/interactions/autocomplete',
    ).replace(queryParameters: {'q': query.toLowerCase().trim()});

    final response = await http.get(uri, headers: _headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      return List<String>.from(data['suggestions'] as List);
    }
    return [];
  }

  Future<List<String>> checkInteractions(String drug1, String drug2) async {
    final uri = Uri.parse(
      '$_baseUrl/interactions/',
    ).replace(queryParameters: {'drug1': drug1, 'drug2': drug2});

    final response = await http.get(uri, headers: _headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      final rawList = data['interactions'] as List;
      debugPrint(
        'Interaction item type: ${rawList.isNotEmpty ? rawList.first.runtimeType : "empty"}',
      );
      debugPrint('First item: ${rawList.isNotEmpty ? rawList.first : "none"}');
      return rawList.map((item) {
        if (item is String) return item;
        if (item is Map)
          return item['description']?.toString() ?? item.toString();
        return item.toString();
      }).toList();
    }

    throw _apiException(response);
  }

  Future<InteractionExplanation> explainInteractions({
    required String drug1,
    required String drug2,
    required String interactionsText,
  }) async {
    final uri = Uri.parse('$_baseUrl/interactions/explain');

    final response = await http.post(
      uri,
      headers: _headers,
      body: json.encode({
        'drug1': drug1,
        'drug2': drug2,
        'interactions_text': interactionsText,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      return InteractionExplanation.fromJson(data);
    }

    throw _apiException(response);
  }

  Exception _apiException(http.Response response) {
    String message;
    try {
      final body = json.decode(response.body) as Map<String, dynamic>;
      message =
          body['detail']?.toString() ??
          response.reasonPhrase ??
          'Unknown error';
    } catch (_) {
      message = response.reasonPhrase ?? 'Unknown error';
    }
    return Exception('API ${response.statusCode}: $message');
  }
}

class InteractionExplanation {
  final String arabic;
  final String english;

  const InteractionExplanation({required this.arabic, required this.english});

  factory InteractionExplanation.fromJson(Map<String, dynamic> json) =>
      InteractionExplanation(
        arabic: json['arabic'] as String? ?? '',
        english: json['english'] as String? ?? '',
      );
}
