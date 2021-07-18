import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_notes/pages/homePage.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn googleSignIn = GoogleSignIn();
final FirebaseAuth auth = FirebaseAuth.instance;
CollectionReference users = FirebaseFirestore.instance.collection('users');

Future<bool> signInWhithGoogle(BuildContext context) async {
  try {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      final UserCredential authResult =
          await auth.signInWithCredential(credential);

      final User user = authResult.user;

      var userData = {
        'name': googleSignInAccount.displayName,
        'provider': 'goolge',
        'photoUrl': googleSignInAccount.photoUrl,
        'email': googleSignInAccount.email,
      };

      users.doc(user.uid).get().then(
        (doc) {
          if (doc.exists) {
            doc.reference.update(userData);

            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          } else {
            users.doc(user.uid).set(userData);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          }
        },
      );
    }
  } catch (PlataformException) {
    print(PlataformException);
    print("No se Puede iniciar Sesión");
  }
}
