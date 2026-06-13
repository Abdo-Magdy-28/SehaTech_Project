import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);

  Future<Map<String, dynamic>> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();

    if (googleUser == null) {
      throw Exception('Sign in cancelled');
    }

    final googleAuth = await googleUser.authentication;

    return {
      'user': {
        'id': googleUser.id,
        'name': googleUser.displayName ?? '',
        'email': googleUser.email,
        'photo': googleUser.photoUrl ?? '',
      },
      'idToken': googleAuth.idToken ?? '',
      'accessToken': googleAuth.accessToken ?? '',
    };
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
