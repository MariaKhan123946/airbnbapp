import 'package:flutter/cupertino.dart';

import 'user_model.dart';

class ContactModel {
  String id;  // Make `id` required and non-nullable
  String firstName;  // Make `firstName` required and non-nullable
  String lastName;  // Make `lastName` required and non-nullable
  String? fullName;  // Optional field
  MemoryImage? displayImage;  // Optional field

  ContactModel({
    required this.id,  // Mark as required
    required this.firstName,  // Mark as required
    required this.lastName,  // Mark as required
    this.fullName,
    this.displayImage,
  });

  // Method to get full name of the user
  String getFullNameOfUser() {
    return '$firstName $lastName';
  }

  // Method to create a UserModel from the ContactModel
  UserModel createUserfromContact() {
    return UserModel(
      id: id,
      firstName: firstName,
      lastName: lastName,
      displayImage: displayImage,
    );
  }
}
