import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class TestCopieFirebaseUser {
  TestCopieFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

TestCopieFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<TestCopieFirebaseUser> testCopieFirebaseUserStream() => FirebaseAuth
    .instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<TestCopieFirebaseUser>(
        (user) => currentUser = TestCopieFirebaseUser(user));
