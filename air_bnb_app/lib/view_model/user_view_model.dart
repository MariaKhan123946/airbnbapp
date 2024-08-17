import 'dart:io';
import 'package:air_bnb_app/model/app_constant.dart';
import 'package:air_bnb_app/model/user_model.dart';
import 'package:air_bnb_app/view/account_screen.dart';
import 'package:air_bnb_app/view/guest_home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserViewModel {
  Future<void> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String city,
    required String country,
    required String bio,
    required File imageFileOfUser,
  }) async {
    Get.snackbar('Please wait', 'Your account is being created');
    try {
      // Create user with email and password
      UserCredential result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String currentUserID = result.user!.uid;

      // Update AppConstant with user details
      AppConstant.currentUser.id = currentUserID;
      AppConstant.currentUser.firstName = firstName;
      AppConstant.currentUser.lastName = lastName;
      AppConstant.currentUser.city = city;
      AppConstant.currentUser.country = country;
      AppConstant.currentUser.bio = bio;
      AppConstant.currentUser.email = email;

      // Save user details to Firestore
      await saveUserToFirestore(
        bio: bio,
        city: city,
        country: country,
        email: email,
        firstName: firstName,
        lastName: lastName,
        id: currentUserID,
      );

      // Add user's image to Firebase Storage
      await addImageUserToFirebaseStorage(imageFileOfUser, currentUserID);

      Get.to(() => GuestHomeScreen());
      Get.snackbar('Congratulations', 'Your account has been created');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> saveUserToFirestore({
    required String bio,
    required String city,
    required String country,
    required String email,
    required String firstName,
    required String lastName,
    required String id,
  }) async {
    Map<String, dynamic> dataMap = {
      'bio': bio,
      'city': city,
      'country': country,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'isMost': false,
      'myPostingIDs': [],
      'savePostingIDs': [],
      'earnings': 0,
    };
    await FirebaseFirestore.instance.collection('users').doc(id).set(dataMap);
  }

  Future<void> addImageUserToFirebaseStorage(File imageFileOfUser, String currentUserID) async {
    try {
      Reference referenceStorage = FirebaseStorage.instance
          .ref()
          .child('userImages')
          .child(currentUserID)
          .child('$currentUserID.png');

      await referenceStorage.putFile(imageFileOfUser);

      final bytes = await imageFileOfUser.readAsBytes();
      AppConstant.currentUser.displayImage = MemoryImage(bytes);
    } catch (e) {
      Get.snackbar('Image Upload Error', e.toString());
    }
  }

  Future<void> login(String email, String password) async {
    Get.snackbar('Please wait', 'Checking your credentials');
    try {
      UserCredential result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      String currentUserID = result.user!.uid;
      AppConstant.currentUser.id = currentUserID;

      await getUserInfoFromFirestore(currentUserID);
      await getImageFromStorage(currentUserID);

      AppConstant.currentUser.getMyPostingsFromFirestore();

      Get.snackbar('Logged In', 'You are logged in successfully');
      Get.to(() => AccountScreen());
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> getUserInfoFromFirestore(String userID) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(userID).get();

      AppConstant.currentUser.firstName = snapshot['firstName'] ?? '';
      AppConstant.currentUser.lastName = snapshot['lastName'] ?? '';
      AppConstant.currentUser.email = snapshot['email'] ?? '';
      AppConstant.currentUser.bio = snapshot['bio'] ?? '';
      AppConstant.currentUser.city = snapshot['city'] ?? '';
      AppConstant.currentUser.country = snapshot['country'] ?? '';
      AppConstant.currentUser.isMost = snapshot['isMost'] ?? false;
    } catch (e) {
      Get.snackbar('Firestore Error', e.toString());
    }
  }

  Future<MemoryImage?> getImageFromStorage(String userID) async {
    if (AppConstant.currentUser.displayImage != null) {
      return AppConstant.currentUser.displayImage;
    }

    try {
      final imageDataInBytes = await FirebaseStorage.instance
          .ref()
          .child('userImages')
          .child(userID)
          .child('$userID.png')
          .getData(1024 * 1024);

      AppConstant.currentUser.displayImage = MemoryImage(imageDataInBytes!);
      return AppConstant.currentUser.displayImage;
    } catch (e) {
      Get.snackbar('Image Load Error', e.toString());
      return null;
    }
  }

  Future<void> becomeMost(String userID) async {
    UserModel userModel = UserModel(id: '');

    userModel.isMost = true;
    Map<String, dynamic> dataMap = {
      'isMost': true,
    };
    await FirebaseFirestore.instance.collection('users').doc(userID).update(dataMap);
  }

  Future<void> modifyCurrentlyHosting({required bool isMosting}) async {
    // Add logic to modify the current hosting status based on the `isMosting` parameter.
    // For example, you might want to update the Firestore document with this status.
  }
}
