import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/datasource/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';

import '../../domain/usecases/login_user.dart';
import '../../domain/usecases/register_user.dart';
import '../../domain/usecases/logout_user.dart';

// ================= STATE =================
class AuthState {
  final User? user;
  final bool isLoading;
  final String? error;

  AuthState({this.user, this.isLoading = false, this.error});

  AuthState copyWith({User? user, bool? isLoading, String? error}) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// ================= NOTIFIER =================
class AuthNotifier extends Notifier<AuthState> {
  late final LoginUser _loginUser;
  late final RegisterUser _registerUser;
  late final LogoutUser _logoutUser;
  late final AuthRepositoryImpl _repository;

  StreamSubscription<User?>? _authSub;

  @override
  AuthState build() {
    final remote = AuthRemoteDatasource();
    _repository = AuthRepositoryImpl(remote);

    _loginUser = LoginUser(_repository);
    _registerUser = RegisterUser(_repository);
    _logoutUser = LogoutUser(_repository);

    _listenAuthState();

    ref.onDispose(() {
      _authSub?.cancel();
    });

    return AuthState();
  }

  void _listenAuthState() {
    _authSub = _repository.authStateChanges().listen((user) {
      state = state.copyWith(user: user);
    });
  }

  // ================= REGISTER =================
  Future<bool> register({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final user = await _registerUser(
        email: email,
        password: password,
        fullName: fullName,
      );

      state = state.copyWith(isLoading: false, user: user);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  // ================= LOGIN =================
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final user = await _loginUser(
        email: email,
        password: password,
      );

      state = state.copyWith(isLoading: false, user: user);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  // ================= LOGOUT =================
  Future<void> logout() async {
    await _logoutUser();
    state = AuthState();
  }
}

// ================= PROVIDER =================
final authProvider =
    NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'dart:async'; // Tambahkan ini untuk StreamSubscription

// // ================= STATE =================
// class AuthState {
//   final User? user;
//   final bool isLoading;
//   final String? error;

//   AuthState({this.user, this.isLoading = false, this.error});

//   AuthState copyWith({User? user, bool? isLoading, String? error}) {
//     return AuthState(
//       user: user ?? this.user,
//       isLoading: isLoading ?? this.isLoading,
//       error: error,
//     );
//   }
// }

// // ================= NOTIFIER =================
// // Ganti StateNotifier dengan Notifier
// class AuthNotifier extends Notifier<AuthState> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   StreamSubscription<User?>? _authStateSubscription;

//   @override
//   AuthState build() {
//     // Inisialisasi listener saat provider pertama kali dibangun
//     _listenAuthState();
    
//     // Pastikan membatalkan subscription saat provider di-dispose
//     ref.onDispose(() {
//       _authStateSubscription?.cancel();
//     });

//     return AuthState(); // Initial state
//   }

//   void _listenAuthState() {
//     _authStateSubscription = _auth.authStateChanges().listen((user) {
//       state = state.copyWith(user: user);
//     });
//   }

//   // ================= REGISTER =================
//   Future<bool> register({
//     required String email,
//     required String password,
//     required String fullName,
//   }) async {
//     try {
//       state = state.copyWith(isLoading: true, error: null);
//       final credential = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       await credential.user?.updateDisplayName(fullName);
//       state = state.copyWith(isLoading: false, user: credential.user);
//       return true;
//     } on FirebaseAuthException catch (e) {
//       state = state.copyWith(isLoading: false, error: e.message);
//       return false;
//     } catch (e) {
//       state = state.copyWith(isLoading: false, error: 'Terjadi kesalahan');
//       return false;
//     }
//   }

//   // ================= LOGIN =================
//   Future<bool> login({required String email, required String password}) async {
//     try {
//       state = state.copyWith(isLoading: true, error: null);
//       final credential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       state = state.copyWith(isLoading: false, user: credential.user);
//       return true;
//     } on FirebaseAuthException catch (e) {
//       state = state.copyWith(isLoading: false, error: e.message);
//       return false;
//     } catch (e) {
//       state = state.copyWith(isLoading: false, error: 'Terjadi kesalahan');
//       return false;
//     }
//   }

//   // ================= LOGOUT =================
//   Future<void> logout() async {
//     await _auth.signOut();
//     state = AuthState();
//   }
// }

// // ================= PROVIDER =================
// // Gunakan NotifierProvider, bukan StateNotifierProvider
// final authProvider = NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);
