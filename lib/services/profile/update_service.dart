import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grad_project/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:grad_project/constants.dart';

final storage = FlutterSecureStorage();

Future<bool> updateMe({
  String? firstName,
  String? lastName,
  String? phone,
  String? dateOfBirth,
  String? address,
}) async {
  try {
    final token = await storage.read(key: 'auth_token') ?? '';

    final body = <String, dynamic>{};
    if (firstName != null && firstName.isNotEmpty)
      body['firstName'] = firstName;
    if (lastName != null && lastName.isNotEmpty) body['lastName'] = lastName;
    if (phone != null && phone.isNotEmpty) body['phoneNumber'] = phone;
    if (dateOfBirth != null && dateOfBirth.isNotEmpty)
      body['date'] = dateOfBirth;
    if (address != null && address.isNotEmpty) body['address'] = address;

    final response = await http.patch(
      Uri.parse('$apiurl/api/users/updateMe'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode != 200) {
      print('updateMe failed: ${response.statusCode} ${response.body}');
      return false;
    }

    final updatedUserJson = jsonDecode(response.body);
    final updatedUser = User.fromJson(updatedUserJson['data']['user']);

    await storage.write(
      key: 'user_data',
      value: jsonEncode(updatedUser.toJson()),
    );

    return true;
  } catch (e) {
    print('updateMe error: $e');
    return false;
  }
}
