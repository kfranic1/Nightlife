import 'package:firebase_auth/firebase_auth.dart';
import 'package:nightlife/model/person.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<Person?> get authStateChanges => _auth.userChanges().asyncMap((firebaseUser) async {
        if (firebaseUser != null) {
          return await Person.person(firebaseUser.uid);
        } else
          return null;
      });

  bool get hasUser => _auth.currentUser != null;

  Future<String?> signIn({required String email, required String password}) =>
      _execute(() async => await _auth.signInWithEmailAndPassword(email: email, password: password));

  Future<String?> signUp({required String email, required String password, required String name}) => _execute(() async => await _auth
      .createUserWithEmailAndPassword(email: email, password: password)
      .then((userCredential) async => await Person.createPerson(userCredential.user!.uid, name: name)));

  Future<String?> signInWithGoogle() => _execute(() async => await _auth
      .signInWithPopup(GoogleAuthProvider())
      .then((userCredential) async => await Person.createPerson(userCredential.user!.uid, name: userCredential.user!.displayName!)));

  Future<String?> signOut() => _execute(() async => await _auth.signOut());

  Future<String?> _execute(Function action) async {
    try {
      await action();
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == "popup-closed-by-user") return null;
      return e.message;
    } catch (e) {
      return "Something went wrong";
    }
  }
}
