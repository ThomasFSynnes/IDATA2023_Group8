import 'package:flutter/material.dart';
import 'package:user_manuals_app/data/manufacturers.dart';
import 'package:user_manuals_app/model/category.dart';
import 'package:user_manuals_app/model/manufacture.dart';
import 'package:user_manuals_app/model/product.dart';
import 'package:user_manuals_app/data/categories.dart';

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
  var _selectedManufactures = manufactures[Manufacturers.Others]!;
  var _selectedCategory = categories[Categories.Others]!;
  var _enteredimageUrl = '';
  String? _enteredreleaseYear = '';
  String? _enteredmodelNumber = '';

  void _saveItem() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.of(context).pop(
        Product(
          id: DateTime.now().toString(),
          title: _enteredName,
          category: _selectedCategory,
          manufacture: _selectedManufactures,
          imageUrl: _enteredimageUrl,
          modelNumber: _enteredmodelNumber,
          releaseYear: _enteredreleaseYear,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      appBar: AppBar(
        title: Text('Add a new product',
            style: Theme.of(context).textTheme.titleLarge),
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onBackground),
                maxLength: 50,
                decoration: InputDecoration(
                  label: Text(
                    'Product Name',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 50) {
                    return 'Must be between 1 and 50 characters.';
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
                      iconEnabledColor: Theme.of(context).colorScheme.onPrimary,
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
                      iconEnabledColor: Theme.of(context).colorScheme.onPrimary,
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
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                keyboardType: TextInputType.number,
                maxLength: 4,
                decoration: InputDecoration(
                  label: Text(
                    'Release Year (Optional)',
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
              // Optional Model Number Input
              TextFormField(
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                decoration: InputDecoration(
                  label: Text(
                    'Model Number (Optional)',
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
                    child: Text('Add Item',
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
    );
  }
}
