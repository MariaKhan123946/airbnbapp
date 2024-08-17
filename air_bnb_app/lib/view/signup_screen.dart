import 'dart:io';

import 'package:air_bnb_app/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _citynameController = TextEditingController();
  TextEditingController _countrynameController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  File? imageFileOfUser;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imageFileOfUser = File(pickedFile.path);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
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
        ),
        title: Text(
          'Create New Account',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
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
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(
                        fontSize: 24,
                      ),
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || !value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(
                        fontSize: 24,
                      ),
                      controller: _passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'First Name',
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(
                        fontSize: 24,
                      ),
                      controller: _firstnameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a first name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(
                        fontSize: 24,
                      ),
                      controller: _lastnameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a last name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Country Name',
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(
                        fontSize: 24,
                      ),
                      controller: _countrynameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a country';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'City',
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(
                        fontSize: 24,
                      ),
                      controller: _citynameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a city';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Bio',
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(
                        fontSize: 24,
                      ),
                      controller: _bioController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a bio';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: MaterialButton(
                        onPressed: _pickImage,
                        child: imageFileOfUser == null
                            ? Icon(Icons.add_a_photo)
                            : CircleAvatar(
                          radius: MediaQuery.of(context).size.width / 5.0,
                          child: CircleAvatar(
                            backgroundColor: Colors.pink,
                            backgroundImage: FileImage(imageFileOfUser!),
                            radius: MediaQuery.of(context).size.width / 5.0,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, right: 40, left: 40),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink,
                        ),
                        onPressed: () async {
                          if (!_formKey.currentState!.validate() || imageFileOfUser == null) {
                            Get.snackbar('Field Missing', 'Please choose an image and fill out the complete signup form');
                            return;
                          }

                          await UserViewModel().signUp(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                            firstName: _firstnameController.text.trim(),
                            lastName: _lastnameController.text.trim(),
                            city: _citynameController.text.trim(),
                            country: _countrynameController.text.trim(),
                            bio: _bioController.text.trim(),
                            imageFileOfUser: imageFileOfUser!,
                          );
                          // Handle post-signup logic here
                        },
                        child: Text(
                          'Create Account',
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => SignupScreen());
                      },
                      child: Text(
                        'Don\'t have an account? Create here.',
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

