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

class EditManual extends StatefulWidget {
  const EditManual({
    super.key,
    required this.product,
  });

  final Product product;
  
  @override
  State<EditManual> createState() {
    return _EditManualState();
  }
}

class _EditManualState extends State<EditManual> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _selectedManufactures = manufactures[Manufacturers.others]!;
  var _selectedCategory = categories[Categories.others]!;
  String? _enteredreleaseYear = '';
  String? _enteredmodelNumber = '';
  String imagePath = "";
  String pdfPath = "";
  File? _imageFile = null;
  File? _pdfFile = null;

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

  Future<void> _pickPDF() async {
    EasyLoading.dismiss();
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
    EasyLoading.show(status: 'loading...');
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_imageFile != null){
        imagePath = await _uploadImage();
      }
      if (_pdfFile != null){
        pdfPath = await _uploadFile(_pdfFile);
      }

      if (!context.mounted) {
        EasyLoading.dismiss();
        return;
      }
      EasyLoading.dismiss();
      
      Navigator.of(context).pop(
        Product(
          id: widget.product.id,
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading image: $e')),
      );
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
    _enteredName = widget.product.title;
    _selectedManufactures = widget.product.manufacture;
    _selectedCategory = widget.product.category;
    _enteredreleaseYear = widget.product.releaseYear;
    _enteredmodelNumber = widget.product.modelNumber;
    imagePath = widget.product.imageUrl;
    widget.product.imageUrl;
    
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
                    initialValue: widget.product.title,
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
                    initialValue: _enteredreleaseYear,
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
                    initialValue: _enteredmodelNumber,
                  ),
                ),
                const SizedBox(height: 12),

                Semantics(
                  label: 'Pick Image Button',
                  child: ElevatedButton.icon(
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

                // Show selected image
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
                    Semantics(
                      label: 'Reset Form Button',
                      child: TextButton(
                        onPressed: () {
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
