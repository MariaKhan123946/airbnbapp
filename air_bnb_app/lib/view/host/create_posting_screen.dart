import 'dart:io';
import 'dart:typed_data';
import 'package:air_bnb_app/model/app_constant.dart';
import 'package:air_bnb_app/model/posting_model.dart';
import 'package:air_bnb_app/view/amnities.dart';
import 'package:air_bnb_app/view/host_home_screen.dart';
import 'package:air_bnb_app/view_model/global.dart';
import 'package:air_bnb_app/view_model/posting_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostingScreen extends StatefulWidget {
  const CreatePostingScreen({super.key});

  @override
  State<CreatePostingScreen> createState() => _CreatePostingScreenState();
}

class _CreatePostingScreenState extends State<CreatePostingScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityNameController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _amenitiesController = TextEditingController();

  final List<String> residenceTypes = [
    'Detached House',
    'Villa',
    'Apartment',
    'Condo',
    'Flat',
    'Town House',
    'Studio',
  ];

  String residenceTypeSelected = '';
  Map<String, int> _beds = {};
  Map<String, int> _bathrooms = {};
  List<MemoryImage> _imagesList = [];

  @override
  void initState() {
    super.initState();
    initializeValues();
  }

  void initializeValues() {
    _nameController.clear();
    _priceController.clear();
    _descriptionController.clear();
    _addressController.clear();
    _cityNameController.clear();
    _countryController.clear();
    residenceTypeSelected = residenceTypes.first;

    _beds = {
      'small': 0,
      'medium': 0,
      'large': 0,
    };

    _bathrooms = {
      'full': 0,
      'half': 0,
    };

    _imagesList = [];
  }

  Future<void> _selectImageFromGallery(int index) async {
    final XFile? imageFilePickedFromGallery =
    await ImagePicker().pickImage(source: ImageSource.gallery);

    if (imageFilePickedFromGallery != null) {
      final File imageFile = File(imageFilePickedFromGallery.path);
      final MemoryImage newImage = MemoryImage(await imageFile.readAsBytes());

      setState(() {
        if (index < _imagesList.length) {
          _imagesList[index] = newImage;
        } else {
          _imagesList.add(newImage);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
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
        ),
        title: const Text(
          'Create/Update a Listing',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                PostingModel postingModel = PostingModel();

                postingModel.name = _nameController.text;
                postingModel.description = _descriptionController.text;
                postingModel.address = _addressController.text;
                postingModel.city = _cityNameController.text;
                postingModel.country = _countryController.text;
                postingModel.amenities = _amenitiesController.text.split(',');
                postingModel.type = residenceTypeSelected;
                postingModel.beds = _beds;
                postingModel.bathrooms = _bathrooms;
                postingModel.displayImages = _imagesList; // Updated line
                postingModel.host = AppConstant.currentUser.createUserfromContact();
                postingModel.setImagesName();
                postingModel.rating = 3.5;
                postingModel.bookings = [];
                postingModel.reviews = [];

                PostingViewModel postingViewModel = PostingViewModel(); // Instantiate the view model
                await postingViewModel.addListingInfoToFirestore();

                await postingViewModel.addImagesToFirebaseStorage();
                Get.to(const HostHomeScreen());
              }
            },
            icon: const Icon(Icons.upload),
          ),

        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(26, 26, 26, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Listing Name',
                          border: OutlineInputBorder(),
                        ),
                        style: const TextStyle(
                          fontSize: 24,
                        ),
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid name';
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: DropdownButton<String>(
                          items: residenceTypes.map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (valueItem) {
                            setState(() {
                              residenceTypeSelected = valueItem!;
                            });
                          },
                          isExpanded: true,
                          value: residenceTypeSelected,
                          hint: const Text(
                            'Select property type',
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 21.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Price',
                                ),
                                style: const TextStyle(
                                  fontSize: 25.0,
                                ),
                                keyboardType: TextInputType.number,
                                controller: _priceController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a valid price';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                              child: Text(
                                '\$/night',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 21.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Description',
                          ),
                          style: const TextStyle(
                            fontSize: 25.0,
                          ),
                          keyboardType: TextInputType.multiline,
                          controller: _descriptionController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a valid description';
                            }
                            return null;
                          },
                          maxLines: 3,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 21.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Address',
                          ),
                          style: const TextStyle(
                            fontSize: 25.0,
                          ),
                          keyboardType: TextInputType.text,
                          controller: _addressController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a valid address';
                            }
                            return null;
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 30.0),
                        child: Text(
                          'Beds',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 21.0, left: 15.0, right: 15.0),
                        child: Column(
                          children: <Widget>[
                            AmenitiesUi(
                              type: 'Twin/single',
                              startValue: _beds['small']!,
                              decreaseValue: () {
                                setState(() {
                                  _beds['small'] =
                                      (_beds['small']! - 1).clamp(0, 10);
                                });
                              },
                              increaseValue: () {
                                setState(() {
                                  _beds['small'] = _beds['small']! + 1;
                                });
                              },
                            ),
                            AmenitiesUi(
                              type: 'Double',
                              startValue: _beds['medium']!,
                              decreaseValue: () {
                                setState(() {
                                  _beds['medium'] =
                                      (_beds['medium']! - 1).clamp(0, 10);
                                });
                              },
                              increaseValue: () {
                                setState(() {
                                  _beds['medium'] = _beds['medium']! + 1;
                                });
                              },
                            ),
                            AmenitiesUi(
                              type: 'King',
                              startValue: _beds['large']!,
                              decreaseValue: () {
                                setState(() {
                                  _beds['large'] =
                                      (_beds['large']! - 1).clamp(0, 10);
                                });
                              },
                              increaseValue: () {
                                setState(() {
                                  _beds['large'] = _beds['large']! + 1;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 30.0),
                        child: Text(
                          'Bathrooms',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 21.0, left: 15.0, right: 15.0),
                        child: Column(
                          children: <Widget>[
                            AmenitiesUi(
                              type: 'Full',
                              startValue: _bathrooms['full']!,
                              decreaseValue: () {
                                setState(() {
                                  _bathrooms['full'] =
                                      (_bathrooms['full']! - 1).clamp(0, 10);
                                });
                              },
                              increaseValue: () {
                                setState(() {
                                  _bathrooms['full'] = _bathrooms['full']! + 1;
                                });
                              },
                            ),
                            AmenitiesUi(
                              type: 'Half',
                              startValue: _bathrooms['half']!,
                              decreaseValue: () {
                                setState(() {
                                  _bathrooms['half'] =
                                      (_bathrooms['half']! - 1).clamp(0, 10);
                                });
                              },
                              increaseValue: () {
                                setState(() {
                                  _bathrooms['half'] = _bathrooms['half']! + 1;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 21.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'City Name',
                          ),
                          style: const TextStyle(
                            fontSize: 25.0,
                          ),
                          keyboardType: TextInputType.text,
                          controller: _cityNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a valid city name';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 21.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Country Name',
                          ),
                          style: const TextStyle(
                            fontSize: 25.0,
                          ),
                          keyboardType: TextInputType.text,
                          controller: _countryController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a valid country name';
                            }
                            return null;
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 30.0),
                        child: Text(
                          'Images',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Wrap(
                            spacing: 10,
                            children: List.generate(
                              6,
                                  (index) => GestureDetector(
                                onTap: () {
                                  _selectImageFromGallery(index);
                                },
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                  ),
                                  child: _imagesList.length > index
                                      ? ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(15),
                                    child: Image.memory(
                                      _imagesList[index].bytes,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                      : const Center(
                                    child: Icon(
                                      Icons.add_a_photo,
                                      color: Colors.grey,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 21.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Amenities (comma separated)',
                          ),
                          style: const TextStyle(
                            fontSize: 25.0,
                          ),
                          keyboardType: TextInputType.text,
                          controller: _amenitiesController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter at least one amenity';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
