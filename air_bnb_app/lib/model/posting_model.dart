import 'package:air_bnb_app/model/booking_model.dart';
import 'package:air_bnb_app/model/contact_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/painting.dart';
import 'review_model.dart';

class PostingModel {
  String? id;
  String name;
  String type;
  double price;
  String description;
  String address;
  String city;
  String country;
  double rating;

  ContactModel? host;
  List<String> imageNames;
  List<MemoryImage> displayImages;
  List<String> amenities;
  Map<String, int> beds;
  Map<String, int> bathrooms;

  List<BookingModel> bookings;
  List<ReviewModel> reviews;

  PostingModel({
    this.id = '',
    this.name = '',
    this.type = '',
    this.price = 0.0,
    this.description = '',
    this.address = '',
    this.city = '',
    this.country = '',
    this.rating = 0.0,
    this.host,
    this.imageNames = const [],
    this.displayImages = const [],
    this.amenities = const [],
    this.beds = const {},
    this.bathrooms = const {},
    this.bookings = const [],
    this.reviews = const [],
  });

  void setImagesName() {
    imageNames = [];
    for (int i = 0; i < displayImages.length; i++) {
      imageNames.add('image_$i.png');
    }
  }

   getPostingInfoFromFirestore()async{

    DocumentSnapshot snapshot=await FirebaseFirestore.instance.collection('postings').doc(id).get();

    getPostingInfoFromFirestore(DocumentSnapshot snapshot){

      address=snapshot['address']??;
      amenities=List<String>.from(snapshot['amnities'])??[];
      bathrooms=Map<String,int>.from(snapshot['bathrooms'])??{};
      beds=Map<String,int>.from(snapshot['beds'])??{};
      city=snapshot['city'] ??'';
      country=snapshot['country']?? '';
      description=snapshot['description']?? '';
       String hostID=snapshot['hostID']?? '';

       host=ContactModel(id: hostID, firstName: '', lastName: '', );


       imageNames=List<String>.from(snapshot['imageNames'])??[];
       name=snapshotp['name']??'';
       price=snapshot['price'].toDouble()??0.0;
       rating=snapshot['rating'].toDouble()??2.5;

       type=snapshot['type']?? '';

    }

  }

}
