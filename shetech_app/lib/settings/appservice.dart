import 'auth.dart';
import 'database_service.dart';

class AppService {
  final AuthService _authService = AuthService();
  final DatabaseService _databaseService = DatabaseService();

  Future<void> signUpAndSaveUser({
    required String email,
    required String password,
    required String name,
  }) async {
    final userCredential = await _authService.signUpWithEmail(
      email: email,
      password: password,
      name: name,
    );

    final uid = userCredential?.user?.uid;
    if (uid != null) {
      await _databaseService.saveUserData(uid, {
        'name': name,
        'email': email,
        'created_at': DateTime.now(),
      });
    }
  }
}
