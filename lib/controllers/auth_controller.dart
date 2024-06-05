import 'package:google_sign_in/google_sign_in.dart';
import '../services/auth_service.dart';

class AuthController {
  final AuthService _authService = AuthService();

  GoogleSignInAccount? get currentUser => _authService.currentUser;

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    return await _authService.signInWithGoogle();
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }
}