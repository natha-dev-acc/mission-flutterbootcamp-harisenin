import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/repositories/auth_repository.dart';
import '../datasource/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Stream<User?> authStateChanges() {
    return remote.authStateChanges();
  }

  @override
  Future<User?> register({
    required String email,
    required String password,
    required String fullName,
  }) {
    return remote.register(
      email: email,
      password: password,
      fullName: fullName,
    );
  }

  @override
  Future<User?> login({
    required String email,
    required String password,
  }) {
    return remote.login(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> logout() {
    return remote.logout();
  }
}