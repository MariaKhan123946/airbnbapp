import 'package:air_bnb_app/model/app_constant.dart';
import 'package:air_bnb_app/view_model/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PostingViewModel {
  Future<void> addListingInfoToFirestore() async {
    postingModel.setImagesName();

    Map<String, dynamic> dataMap = {
      'address': postingModel.address,
      'amenities': postingModel.amenities,
      'bathrooms': postingModel.bathrooms,
      'description': postingModel.description,
      'beds': postingModel.beds,
      'city': postingModel.city,
      "country": postingModel.country,
      'hostID': AppConstant.currentUser.id,
      'imagesName': postingModel.imageNames,
      'name': postingModel.name,
      'price': postingModel.price,
      'rating': 3.5,
      'type': postingModel.type,
    };

    // Add the document to Firestore and get the reference
    DocumentReference ref = await FirebaseFirestore.instance.collection('postings').add(dataMap);

    // Set the id of the postingModel
    postingModel.id = ref.id;

    // After setting the ID, add the posting to the current user's postings
    await AppConstant.currentUser.addPostingToMyPosting(postingModel);
  }

  Future<void> addImagesToFirebaseStorage() async {
    // Make sure postingModel has a valid id before this method is called
    if (postingModel.id == null || postingModel.id!.isEmpty) {
      throw Exception("Posting ID is not set. Ensure addListingInfoToFirestore() is called before addImagesToFirebaseStorage().");
    }

    for (int i = 0; i < postingModel.displayImages!.length; i++) {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('PostingImages')
          .child(postingModel.id!)
          .child(postingModel.imageNames[i]);

      await ref.putData(postingModel.displayImages![i].bytes).whenComplete(() {});
    }
  }
}
