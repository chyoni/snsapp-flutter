import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ! View Model이 필요없기 때문에 Repository class에서 그냥 바로 Provider를 생성
class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool get isLoggedIn => user != null;
  User? get user => _firebaseAuth.currentUser;
}

final authRepo = Provider(
  (ref) => AuthenticationRepository(),
);
