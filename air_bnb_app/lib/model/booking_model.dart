import 'package:air_bnb_app/model/contact_model.dart';
import 'package:air_bnb_app/model/posting_model.dart';

class BookingModel{
  String id='';
  PostingModel? posting;
  ContactModel? contact;
  List<DateTime>? dates;
  BookingModel();
}