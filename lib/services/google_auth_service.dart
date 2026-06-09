// services/auth/google_auth_service.dart
import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grad_project/constants.dart';
import 'package:http/http.dart' as http;

class GoogleAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<Map<String, dynamic>> signInWithGoogle() async {
    // Step 1: trigger google sign in
    final GoogleSignInAccount? account = await _googleSignIn.signIn();
    if (account == null) throw Exception('Sign in cancelled');

    // Step 2: get idToken
    final GoogleSignInAuthentication auth = await account.authentication;
    final String? idToken = auth.idToken;
    if (idToken == null) throw Exception('Failed to get ID token');

    // Step 3: send to your backend
    final response = await http.post(
      Uri.parse('$apiurl/api/v2/auth/google/verify-token'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'idToken': idToken}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Backend error: ${response.body}');
    }
  }

  Future<GoogleSignInAccount?> getCurrentUser() async {
    return await _googleSignIn.signInSilently();
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
