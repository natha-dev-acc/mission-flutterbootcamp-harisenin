import 'package:firebase_auth/firebase_auth.dart';
import '../repositories/auth_repository.dart';

class RegisterUser {
  final AuthRepository repository;

  RegisterUser(this.repository);

  Future<User?> call({
    required String email,
    required String password,
    required String fullName,
  }) {
    return repository.register(
      email: email,
      password: password,
      fullName: fullName,
    );
  }
}