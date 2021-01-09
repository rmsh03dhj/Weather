import 'package:firebase_auth/firebase_auth.dart';
import 'package:weather/features/registration_or_login/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isSignedIn() {
    final currentUser = _auth.currentUser;
    return currentUser != null;
  }

  @override
  User getUser() {
    final currentUser = _auth.currentUser;
    return currentUser;
  }

  @override
  Future<User> signIn(String email, String password) async {
    try {
      UserCredential result =
          await _auth.signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch (e) {
      throw (e);
    }
  }

  @override
  Future<User> signUp(String email, String password) async {
    try {
      UserCredential result =
          await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch (e) {
      throw (e);
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw (e);
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw (e);
    }
  }
}
