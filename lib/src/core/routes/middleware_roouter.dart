import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/* class Auth extends ChangeNotifier {
  FirebaseAuth _firebaseAuth;
  User _user;

  bool get isAuthenticated => _user != null;
  Future<void> init() async {
    _firebaseAuth = FirebaseAuth.instance;
    _firebaseAuth.authStateChanges().listen((User user) {
      _user = user;
      notifyListeners();
    });
  }
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}


class MiddlewareFunction {
  static MiddlewareFunction get authenticate {
    return (context, state, callback) async {
      final auth = context.read<Auth>();
      if (auth.isAuthenticated) {
        await callback();
      } else {
        state.redirect(AppRoutes.login.name);
      }
    };
  }
} */