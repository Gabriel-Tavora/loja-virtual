import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserType extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;

  User? firebaseUser;
  Map<String, dynamic> userData = {};

  bool isLoading = false;

  UserType() {
    auth.authStateChanges().listen((User? user) async {
      firebaseUser = user;

      if (user != null) {
        await loadCurrentUser();
      } else {
        userData.clear();
      }

      notifyListeners();
    });
  }

  Future<void> signIn({
    required String email,
    required String password,
    required VoidCallback onSuccess,
    required Function(String) onFailed,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      await auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      onSuccess();
    } on FirebaseAuthException catch (e) {
      String message;

      switch (e.code) {
        case "user-not-found":
          message = "Usuário não encontrado.";
          break;

        case "wrong-password":
        case "invalid-credential":
          message = "Email ou senha incorretos.";
          break;

        case "invalid-email":
          message = "Email inválido.";
          break;

        case "too-many-requests":
          message = "Muitas tentativas. Tente novamente mais tarde.";
          break;

        default:
          message = e.message ?? "Erro ao fazer login.";
      }

      onFailed(message);
    } catch (_) {
      onFailed("Erro inesperado.");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signUp({
    required Map<String, dynamic> userData,
    required String password,
    required VoidCallback onSuccess,
    required Function(String) onFailed,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      final userCredential = await auth.createUserWithEmailAndPassword(
        email: userData["email"],
        password: password,
      );

      firebaseUser = userCredential.user;

      await saveUserData(userData);

      this.userData = userData;

      onSuccess();
    } on FirebaseAuthException catch (e) {
      String message;

      switch (e.code) {
        case "email-already-in-use":
          message = "Este e-mail já está em uso.";
          break;

        case "weak-password":
          message = "Senha muito fraca.";
          break;

        case "invalid-email":
          message = "E-mail inválido.";
          break;

        default:
          message = e.message ?? "Erro ao criar usuário.";
      }

      onFailed(message);
    } catch (_) {
      onFailed("Erro inesperado.");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveUserData(
    Map<String, dynamic> userData,
  ) async {
    if (firebaseUser == null) return;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser!.uid)
        .set(userData);
  }

  Future<void> loadCurrentUser() async {
    if (firebaseUser == null) return;

    try {
      final doc = await FirebaseFirestore.instance
          .collection("users")
          .doc(firebaseUser!.uid)
          .get();

      if (doc.exists) {
        userData = doc.data()!;
      }
    } catch (e) {
      debugPrint("Erro ao carregar usuário: $e");
    }
  }

  Future<void> recoverPass(String email) async {
    await auth.sendPasswordResetEmail(
      email: email.trim(),
    );
  }

  Future<void> signOut() async {
    await auth.signOut();

    firebaseUser = null;
    userData.clear();

    notifyListeners();
  }

  bool get isLoggedIn => firebaseUser != null;

  bool get isLoggedOut => firebaseUser == null;
}
