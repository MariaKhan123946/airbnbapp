import 'package:air_bnb_app/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'guest_home_screen.dart'; // Ensure this is the correct path
import 'signup_screen.dart'; // Ensure this is the correct path

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final UserViewModel _userViewModel = UserViewModel(); // Instantiate UserViewModel

  @override
  void dispose() {
    // Dispose of controllers to avoid memory leaks
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.pinkAccent,
              Colors.amber,
            ],
            begin: FractionalOffset(0, 0),
            end: FractionalOffset(1, 0),
            stops: [0, 1],
            tileMode: TileMode.clamp,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Image.asset('images/img.png', width: 240),
            ),
            const SizedBox(height: 20),
            const Text(
              'Hello Friend \nWelcome back',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.pink,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                      controller: _emailController,
                      validator: (valueEmail) {
                        if (valueEmail == null || !valueEmail.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                      controller: _passwordController,
                      obscureText: true,
                      validator: (valuePassword) {
                        if (valuePassword == null || valuePassword.isEmpty) {
                          return 'Please enter a password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(top: 26.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink,
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // Call the login method on the UserViewModel instance
                            await _userViewModel.login(
                              _emailController.text.trim(),
                              _passwordController.text.trim(),
                            );
                          }
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to the signup screen
                        Get.to(() => SignupScreen()); // Update the screen navigation
                      },
                      child: const Text(
                        'Don\'t have an account? Create here.',
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => GuestHomeScreen()); // Optional, if you have a guest mode
                      },
                      child: const Text(
                        'Continue as Guest',
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
