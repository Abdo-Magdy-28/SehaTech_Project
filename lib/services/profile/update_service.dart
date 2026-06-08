import 'dart:io';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grad_project/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:grad_project/constants.dart';
import 'package:http_parser/http_parser.dart';

Future<bool> updateMe({
  String? firstName,
  String? lastName,
  String? phone,
  String? dateOfBirth,
  String? address,
  File? imageFile,
}) async {
  final storage = FlutterSecureStorage();
  try {
    final token = await storage.read(key: 'auth_token') ?? '';

    final uri = Uri.parse('$apiurl/api/users/updateMe');
    final request = http.MultipartRequest('PATCH', uri);

    // ✅ Add headers
    request.headers['Authorization'] = 'Bearer $token';

    // ✅ Add text fields
    if (firstName != null && firstName.isNotEmpty) {
      request.fields['firstName'] = firstName;
    }
    if (lastName != null && lastName.isNotEmpty) {
      request.fields['lastName'] = lastName;
    }
    if (phone != null && phone.isNotEmpty) {
      request.fields['phoneNumber'] = phone;
    }
    if (dateOfBirth != null && dateOfBirth.isNotEmpty) {
      request.fields['date'] = dateOfBirth;
    }
    if (address != null && address.isNotEmpty) {
      request.fields['address'] = address;
    }

    // ✅ Add image file if provided
    if (imageFile != null) {
      print("Image path: ${imageFile.path}");
      request.files.add(
        await http.MultipartFile.fromPath(
          'photo',
          imageFile.path,
          contentType: MediaType('image', 'jpeg'),
        ),
      );
      print(request.files.length);
    }

    // ✅ Send request
    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode != 200) {
      print('updateMe failed: ${response.statusCode} $responseBody');
      return false;
    }

    // ✅ Parse updated user from response
    final updatedUserJson = jsonDecode(responseBody);
    final updatedUser = User.fromJson(updatedUserJson['data']['user']);

    // ✅ Save all user fields locally
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
