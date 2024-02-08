import 'package:flutter/material.dart';
import 'package:optimizer/auth/create.dart';
import 'package:optimizer/auth/forgotpass.dart';
import 'package:optimizer/controller/signin.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200,
                width: 200,
                decoration: const BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage('assets/logo.png'))),
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                'CRIS',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black45,
                  fontSize: 20,
                ),
              ),

              // Cemetery Record Information System
              const Text(
                'Cemetery Record Information System',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 30),

              // username textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: TextField(
                  controller: _userController,
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    hintText: 'username',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  // obscureText: true,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              // password textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    hintText: 'password',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                color: Colors.transparent,
                width: 300,
                child: ElevatedButton(
                  onPressed: () async {
                    final email = _userController.text.trim();
                    final password = _passwordController.text.trim();

                    signIn(context, email, password);
                  },
                  child: const Text('Login'),
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              // Forgot Password
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgotPassword(),
                    ),
                  );
                },
                child: const Text('Forgot Password?'),
              ),

              const SizedBox(height: 30),

              // Create Account

              Container(
                color: Colors.transparent,
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Create(),
                      ),
                    );
                  },
                  child: const Text('Create Account'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
