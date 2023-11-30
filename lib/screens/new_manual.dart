import 'package:flutter/material.dart';
import 'package:user_manuals_app/data/manufacturers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:user_manuals_app/model/category.dart';
import 'package:user_manuals_app/model/manufacture.dart';
import 'package:user_manuals_app/model/product.dart';
import 'package:user_manuals_app/data/categories.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

//**
// Flutter page for a form to add new manual/product to the app
//
// */

class NewManual extends StatefulWidget {
  const NewManual({super.key});

  @override
  State<NewManual> createState() {
    return _NewManualState();
  }
}

class _NewManualState extends State<NewManual> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = ''; //Product name
  var _selectedManufactures = manufactures[
      Manufacturers.others]!; //Selected manufacturer (Defaults to: Other)
  var _selectedCategory =
      categories[Categories.others]!; //Selected Category (Defaults to: Other)
  String? _enteredreleaseYear = ''; //Optional release year
  String? _enteredmodelNumber = ''; //Optional model number
  File? _imageFile; //Image file for product
  File? _pdfFile; //PDF file for product

  // Function to handle image pick from gallery
  Future<void> _pickImage() async {
    EasyLoading.dismiss();
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

// Function to handle PDF pick from files
  Future<void> _pickPDF() async {
    EasyLoading.dismiss();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'], //only allows pdf extension
    );

    if (result != null) {
      setState(() {
        _pdfFile = File(result.files.single.path!);
      });
    }
  }

  void _saveItem() async {
    EasyLoading.show(status: 'loading...');
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      String imagePath = await _uploadImage();
      String pdfPath = await _uploadFile(_pdfFile);

      if (!context.mounted) {
        EasyLoading.dismiss();
        return;
      }
      EasyLoading.dismiss();
      Navigator.of(context).pop(
        Product(
          id: DateTime.now()
              .toString(), //ID is DateTime.now (example: 2023-11-22 19:24:28.414463) Should be changed in the future
          title: _enteredName,
          category: _selectedCategory,
          manufacture: _selectedManufactures,
          imageUrl: imagePath,
          pdfUrl: pdfPath,
          modelNumber: _enteredmodelNumber,
          releaseYear: _enteredreleaseYear,
        ),
      );
    }
    EasyLoading.dismiss();
  }

  //Method for uploading image to FireStore and return download URL
  Future<String> _uploadImage() async {
    try {
      if (_imageFile == null) {
        return ''; // Return an empty string or handle accordingly if no image is selected
      }

      final Reference storageReference = FirebaseStorage.instance.ref().child(
          'images/${DateTime.now().toString()}'); //ID is DateTime.now (example: 2023-11-22 19:24:28.414463) Should be changed in the future

      await storageReference.putFile(_imageFile!);

      return await storageReference.getDownloadURL();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading image: $e')),
      );
      return '';
    }
  }

  //Method for uploading PDF to FireStore and return download URL
  Future<String> _uploadFile(File? file) async {
    if (file == null) {
      return ''; // Return an empty string or handle accordingly if no file is selected
    }

    final Reference storageReference = FirebaseStorage.instance.ref().child(
        'files/${DateTime.now().toString()}'); //ID is DateTime.now (example: 2023-11-22 19:24:28.414463) Should be changed in the future

    await storageReference.putFile(file);

    return await storageReference.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      appBar: AppBar(
        title: Text("newManual.text.AddProduct".tr(),
            style: Theme.of(context).textTheme.titleLarge),
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Semantics(
                  label: 'Product Name Input',
                  child: TextFormField(
                    //input for Product name
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onBackground),
                    maxLength: 50,
                    decoration: InputDecoration(
                      label: Text(
                        "newManual.text.ProductName".tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                    ),
                    validator: (value) {
                      //validates the product name which must be withing 0-50 length and not empty
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().length <= 1 ||
                          value.trim().length > 50) {
                        return "newManual.text.errorLength".tr();
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _enteredName = value!;
                    },
                  ),
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(width: 8),
                    Expanded(
                      child: Semantics(
                        label: 'Select Category Dropdown',
                        child: DropdownButtonFormField(
                          //Drop down for category, defaults to other
                          iconEnabledColor:
                              Theme.of(context).colorScheme.onPrimary,
                          dropdownColor:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          value: _selectedCategory,
                          items: [
                            for (final category in categories.entries)
                              DropdownMenuItem(
                                value: category.value,
                                child: Row(
                                  children: [
                                    const SizedBox(width: 6),
                                    Text(category.value.title),
                                  ],
                                ),
                              ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value!;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Semantics(
                        label: 'Select Manufacture Dropdown',
                        child: DropdownButtonFormField(
                          //Drop down for manufacturer, defaults to other
                          iconEnabledColor:
                              Theme.of(context).colorScheme.onPrimary,
                          dropdownColor:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          value: _selectedManufactures,
                          items: [
                            for (final manufacture in manufactures.entries)
                              DropdownMenuItem(
                                value: manufacture.value,
                                child: Row(
                                  children: [
                                    const SizedBox(width: 6),
                                    Text(manufacture.value.title),
                                  ],
                                ),
                              ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedManufactures = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Text("newManual.text.ContactUs".tr(),
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.center),
                const SizedBox(width: 16),
                // Optional Release Year Input
                Semantics(
                  label: 'Release Year Input',
                  child: TextFormField(
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    decoration: InputDecoration(
                      label: Text(
                        "newManual.text.releaseYear".tr(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ),
                    onSaved: (value) {
                      _enteredreleaseYear = value;
                    },
                  ),
                ),
                // Optional Model Number Input
                Semantics(
                  label: 'Model number Input',
                  child: TextFormField(
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    decoration: InputDecoration(
                      label: Text(
                        "newManual.text.modelNumber".tr(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ),
                    onSaved: (value) {
                      _enteredmodelNumber = value;
                    },
                  ),
                ),
                const SizedBox(height: 12),

                Semantics(
                  label: 'Pick Image Button',
                  child: ElevatedButton.icon(
                    //button for image picker logic
                    onPressed: _pickImage,
                    icon: Icon(
                      Icons.image,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                    label: Text("newManual.text.pickPicture".tr(),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary)),
                  ),
                ),

                // Show selected image under button
                _imageFile != null
                    ? Image.file(
                        _imageFile!,
                        height: 50,
                        width: 50,
                      )
                    : const SizedBox(height: 0, width: 0),

                Semantics(
                  label: 'Pick PDF Button',
                  child: ElevatedButton.icon(
                    //button for pdf picker logic
                    onPressed: _pickPDF,
                    icon: Icon(
                      Icons.picture_as_pdf,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                    label: Text("newManual.text.pickPDF".tr(),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary)),
                  ),
                ),
                // Show text that a PDF file has been selected
                _pdfFile != null
                    ? Text(
                        "newManual.text.uplaodedPDF".tr(),
                        style: Theme.of(context).textTheme.titleMedium,
                      )
                    : const SizedBox(height: 0, width: 0),

                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Semantics(
                      label: 'Reset Form Button',
                      child: TextButton(
                        //button for resetting form
                        onPressed: () {
                          //resetts everything in the form to default/empty fields
                          _formKey.currentState!.reset();
                          _imageFile = null;
                          _pdfFile = null;
                          _selectedCategory = categories[Categories.others]!;
                          _selectedManufactures =
                              manufactures[Manufacturers.others]!;
                        },
                        child: Text('Reset',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                            )),
                      ),
                    ),
                    Semantics(
                      label: 'Save Item Button',
                      child: ElevatedButton(
                        //button for submitting form
                        onPressed: _saveItem,
                        child: Text("newManual.text.addItem".tr(),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSecondary,
                            )),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
