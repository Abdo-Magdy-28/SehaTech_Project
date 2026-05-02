import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void printToken() async {
  final storage = FlutterSecureStorage();
  final token = await storage.read(key: 'auth_token') ?? '';
  debugPrint('TOKEN: $token');
}
