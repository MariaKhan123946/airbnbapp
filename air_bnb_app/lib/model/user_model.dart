import 'dart:js_interop';

import 'package:air_bnb_app/model/booking_model.dart';
import 'package:air_bnb_app/model/contact_model.dart';
import 'package:air_bnb_app/model/posting_model.dart';
import 'package:air_bnb_app/view_model/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'review_model.dart';

class UserModel extends ContactModel {
  String email;
  String bio;
  String city;
  String country;
  bool? isWork;
  bool? isCurrentWorking;
  bool isMost;
  bool isCurrentlyMosting;
  DocumentSnapshot? snapshot;
  List<BookingModel>? bookings;
  List<ReviewModel>? reviews;
  List<PostingModel>? myPosting;

  UserModel({
    required String id,  // Ensure id is non-nullable and required
    String firstName = '',  // Provide default values for firstName
    String lastName = '',  // Provide default values for lastName
    MemoryImage? displayImage,
    this.email = '',
    this.bio = '',
    this.city = '',
    this.country = '',
    this.isWork,
    this.isCurrentWorking,
    this.snapshot,
    this.isMost = false,
    this.isCurrentlyMosting = false,
  }) : super(
    id: id,  // Pass the non-nullable id to the super constructor
    firstName: firstName,  // Pass the firstName with default value
    lastName: lastName,  // Pass the lastName with default value
    displayImage: displayImage,
  ) {
    // Initialize lists
    bookings = [];
    reviews = [];
    myPosting = [];
  }

  Future<void> addPostingToMyPosting(PostingModel posting) async {
    myPosting!.add(posting);

    List<String> myPostingIDsList =[];
    myPosting!.forEach(element){
      myPostingIDsList.add(element.id!);
    });

    await FirebaseFirestore.instance.collection('users').doc(id).update({
      'myPostingIDs': myPostingIDsList,
    });
  }

  getMyPostingsFromFirestore()async{
    List<String>myPostingIDs=List<String>.from(snapshot!['myPostingIDs'])??[];

    for(String postingID in myPostingIDs){
      PostingModel posting=PostingModel(id: postingID);

     await posting.getPostingInfoFromFirestore();

     myPosting!.add(posting);


    }
  }
}
