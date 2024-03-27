import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:[ Container(
          height: MediaQuery.sizeOf(context).height,
          width:MediaQuery.sizeOf(context).width,
          decoration: const BoxDecoration(
            image: DecorationImage(image:AssetImage('assets/pic/design1.png'),
              opacity:1)
          ),),
          /*Center(
            child: Image.asset(
              'assets/Lyanna.png',
              height: 120,
              width: MediaQuery.sizeOf(context).width/1.4,
              fit: BoxFit.cover,
              
            ),
          ),*/
          Center(
            child: GestureDetector(
              onTap: signInWithGoogle,
              child: Container(
                margin: EdgeInsets.only(top: MediaQuery.sizeOf(context).height/1.4),
                height:70,
                width:MediaQuery.sizeOf(context).width/1.2,
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 2.5),
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/pic/glogo.png',
                      height: 50,width: 50,
                      fit: BoxFit.cover,
                    ),
                    const Text(
                      'Login with Google',
                     style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                     ),
                    )
                  ],
                ),
              ),
            ),
          ),
        
      ])
    );
  }
}

Future<bool> signInWithGoogle()async{
  bool result =false;
  try {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken ,
    idToken: googleAuth?.idToken,
  );
  UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
  
  User?user= userCredential.user;

      if (user!=null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
            'username':user.displayName,
            'uid':user.uid,
            'profilePhoto':user.photoURL,
            'email':user.email,
          });
        }
        result=true;
      }
  } on FirebaseAuthException catch (e) {
      result= false;
      SnackBar(content:Text(e.toString()));
    }return result;
  
}