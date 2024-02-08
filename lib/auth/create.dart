// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:optimizer/auth/login.dart';
import 'package:optimizer/data/smtp.dart';

class Create extends StatefulWidget {
  const Create({super.key});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController publicNameController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();

// Function to simulate creating an account
  Future<void> createAccount() async {
    const String purpose = "signup";
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;
    String publicName = publicNameController.text;
    String fullName = fullNameController.text;
    String zipcode = zipcodeController.text;

    if (password == confirmPassword) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        sendEmailNotification(purpose, email);
        message_sign();
        details(email, publicName, fullName, zipcode);
      } on FirebaseAuthException catch (e) {
        print(e.message); // Log the error for debugging
        message_error(); // Display a user-friendly error message
      }
    } else {
      message_error();
    }
  }

  Future details(
    String email,
    String public,
    String fullname,
    String zipcode,
  ) async {
    await FirebaseFirestore.instance.collection('Users').doc(email).set({
      'email': email,
      'public name': public,
      'full name': fullname,
      'address': zipcode,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      backgroundColor: Colors.orange[500],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 14.0,
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 14.0),
              TextFormField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 14.0),
              TextFormField(
                controller: publicNameController,
                decoration: const InputDecoration(
                  labelText: 'Public Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 14.0),
              TextFormField(
                controller: fullNameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 14.0),
              TextFormField(
                controller: zipcodeController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
              ),
              ElevatedButton(
                onPressed: createAccount,
                child: const Text('Create Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future message_sign() async {
    await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Success"),
          content: const Text("Account Created Successfully"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const Login()));
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future message_error() async {
    await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Passwords do not match!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
