import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Logger _logger = Logger();

  //Check if a user is already signed in
  User? get currentUser {
    return _auth.currentUser;
  }

 // Sign in with email and password (login)
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      _logger.i('User signed in: ${user?.uid}');
      return user;
    } catch (e) {
      _logger.e('Failed to sign in: ${e.toString()}');
      return null;
    }
  }

  // Register with email and password (signup)
   Future<User?> registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      _logger.i('User registered: ${user?.uid}');
      return user;
    } catch (e) {
      _logger.e('Failed to register: ${e.toString()}');
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      _logger.e('Failed to sign out: ${e.toString()}');
    }
  }
}
