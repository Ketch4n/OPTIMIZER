// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:optimizer/data/session.dart';
import 'package:optimizer/data/smtp.dart';
import 'package:optimizer/pages/home.dart';

Future<void> signIn(BuildContext context, String email, String password) async {
  const String purpose = "login";
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    sendEmailNotification(purpose, email);
    print("Sign-in successful!");
    Session.email = email;
    // Navigate to HomePage if sign-in is successful
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  } on FirebaseAuthException catch (e) {
    print("Error signing in: ${e.message}");

    // Handle authentication errors, such as incorrect email or password
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Email or Password incorrect"),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
