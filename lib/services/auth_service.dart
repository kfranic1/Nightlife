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

  Future<void> signIn({required String email, required String password}) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signUp({required String email, required String password, required String name}) async {
    await _auth.createUserWithEmailAndPassword(email: email, password: password).then((userCredential) async {
      await Person.createPerson(userCredential.user!.uid, name: name);
      await userCredential.user!.updateDisplayName(name);
    });
  }

  Future<void> signInWithGoogle() async => await _signInWithProvider(GoogleAuthProvider());

  Future<void> _signInWithProvider(var provider) async {
    try {
      await _auth.signInWithPopup(provider);
    } catch (e) {
      print(e);
    }
  }

  Future<String?> signOut() async {
    try {
      await _auth.signOut();
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
