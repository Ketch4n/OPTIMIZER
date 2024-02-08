import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optimizer/auth/login.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController forgot = TextEditingController();
  Future<void> _resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // Password reset email sent successfully
      print('Password reset email sent to $email');
    } catch (e) {
      // Handle errors, e.g., if the email address is not registered
      print('Error sending password reset email: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Login(),
                ));
          },
        ),
      ),
      //drawer

      body: SingleChildScrollView(
        child: Column(
          children: [
            const Center(
                child: Text(
              'FORGOT',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            )),
            const Text(
              'PASSWORD',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            const Icon(
              CupertinoIcons.lock_shield,
              size: 150,
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Trouble Logging in?',
              style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.bold, letterSpacing: 2),
            ),
            const SizedBox(
              height: 25,
            ),
            const Text("Enter your email and we'll send a link to reset"),
            const Text('your password'),
            //for elevatedbutton
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 200,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  controller: forgot,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter your email',
                    icon: Icon(
                      Icons.person,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow),
                      onPressed: () {
                        final String email = forgot.text.trim();
                        _resetPassword(email);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Password reset email sent to $email'),
                            duration: const Duration(seconds: 5),
                          ),
                        );
                      },
                      child: const Text('Reset Password')),
                ),
                const SizedBox(
                  height: 52,
                ),
                SizedBox(
                  width: 700,
                  child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.lightBlueAccent),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ));
                      },
                      child: const Text(
                        'Return to login page',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
