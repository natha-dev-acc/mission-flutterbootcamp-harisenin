import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Stream<User?> authStateChanges();

  Future<User?> register({
    required String email,
    required String password,
    required String fullName,
  });

  Future<User?> login({
    required String email,
    required String password,
  });

  Future<void> logout();
}