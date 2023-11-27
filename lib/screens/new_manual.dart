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

class NewManual extends StatefulWidget {
  const NewManual({super.key});

  @override
  State<NewManual> createState() {
    return _NewManualState();
  }
}

class _NewManualState extends State<NewManual> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _selectedManufactures = manufactures[Manufacturers.others]!;
  var _selectedCategory = categories[Categories.others]!;
  String? _enteredreleaseYear = '';
  String? _enteredmodelNumber = '';
  File? _imageFile;
  File? _pdfFile;

  // Function to handle image pick from gallery
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  Future<void> _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _pdfFile = File(result.files.single.path!);
      });
    }
  }

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      String imagePath = await _uploadImage();
      String pdfPath = await _uploadFile(_pdfFile);

      if (!context.mounted) {
        return;
      }

      Navigator.of(context).pop(
        Product(
          id: DateTime.now().toString(),
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
  }

  Future<String> _uploadImage() async {
    try {
      if (_imageFile == null) {
        return ''; // Return an empty string or handle accordingly if no image is selected
      }

      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().toString()}');

      await storageReference.putFile(_imageFile!);

      return await storageReference.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e'); //TODO SCAFFOLD MESSAGE
      return '';
    }
  }

  Future<String> _uploadFile(File? file) async {
    if (file == null) {
      return ''; // Return an empty string or handle accordingly if no file is selected
    }

    final Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('files/${DateTime.now().toString()}');

    await storageReference.putFile(file);

    return await storageReference.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      appBar: AppBar(
        title: Text("newManual.text.AddProduct".tr(),
            style: Theme.of(context).textTheme.titleMedium),
        backgroundColor: Theme.of(context).colorScheme.primary,
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
                TextFormField(
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primaryContainer),
                  maxLength: 50,
                  decoration: InputDecoration(
                    label: Text(
                      "newManual.text.ProductName".tr(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              Theme.of(context).colorScheme.primaryContainer),
                    ),
                  ),
                  validator: (value) {
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
                ), // instead of TextField()
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButtonFormField(
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
                    Expanded(
                      child: DropdownButtonFormField(
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
                  ],
                ),
                const SizedBox(width: 16),
                // Optional Release Year Input
                TextFormField(
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  decoration: InputDecoration(
                    label: Text(
                      "newManual.text.releaseYear".tr(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primaryContainer,
                      ),
                    ),
                  ),
                  onSaved: (value) {
                    _enteredreleaseYear = value;
                  },
                ),
                // Optional Model Number Input
                TextFormField(
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  decoration: InputDecoration(
                    label: Text(
                      "newManual.text.modelNumber".tr(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primaryContainer,
                      ),
                    ),
                  ),
                  onSaved: (value) {
                    _enteredmodelNumber = value;
                  },
                ),
                const SizedBox(height: 12),

                ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: Icon(
                    Icons.image,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                  label: Text("newManual.text.pickPicture".tr(),
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary)),
                ),

                // Show selected image
                _imageFile != null
                    ? Image.file(
                        _imageFile!,
                        height: 50,
                        width: 50,
                      )
                    : const SizedBox(height: 0, width: 0),

                ElevatedButton.icon(
                  onPressed: _pickPDF,
                  icon: Icon(
                    Icons.picture_as_pdf,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                  label: Text("newManual.text.pickPDF".tr(),
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary)),
                ),
                // Show selected PDF file
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
                    TextButton(
                      onPressed: () {
                        _formKey.currentState!.reset();
                      },
                      child: Text('Reset',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          )),
                    ),
                    ElevatedButton(
                      onPressed: _saveItem,
                      child: Text("newManual.text.addItem".tr(),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                          )),
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

//TODO: MAYBE ADD A LOADING SCREEN WHEN UPLOADING
