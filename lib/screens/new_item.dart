import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shopping_list/Data/categories.dart';
import 'package:shopping_list/models/categories.dart';
import 'package:shopping_list/models/grocery_items.dart';
// import 'package:shopping_list/Data/dummy_items.dart';
// import 'package:shopping_list/data/categories.dart';
// import 'package:shopping_list/models/categories.dart';
// import 'package:shopping_list/models/grocery_items.dart';

class AddItenScreen extends StatefulWidget {
  const AddItenScreen({
    super.key,
  });

  // final void Function(Map<Map, GroceryItem> res) onSendData;

  @override
  State<AddItenScreen> createState() => _AddItenScreenState();
}

class _AddItenScreenState extends State<AddItenScreen> {
  final _formKey = GlobalKey<FormState>();
  var nameVal = '';
  var qtyVal = 1;
  var selectedCategory = categories[Categories.carbs];

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final url = Uri.https("flutter-prep-ea807-default-rtdb.firebaseio.com", "shopping-list.json");
      final response = await http.post(
        url,
        headers: {
          'content-type': 'application/json',
        },
        body: json.encode(
          {
            'name': nameVal,
            'quantity': qtyVal,
            'category': selectedCategory!.title,
          },
        ),
      );
      print(response.body);
      print(response.statusCode);

      if (!context.mounted) {
        return;
      }

      Navigator.of(context).pop();
      //   GroceryItem(
      //     id: DateTime.now().toString(),
      //     name: nameVal,
      //     quantity: qtyVal,
      //     category: selectedCategory!,
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Item"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                // controller: _nameController,
                keyboardType: TextInputType.text,
                maxLength: 30,
                decoration: const InputDecoration(
                  label: Text("Item Name"),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length <= 1) {
                    return "Must be a name between 1 to 30 characters";
                  }
                  return null;
                },
                onSaved: (value) {
                  nameVal = value!;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      // controller: _qtyController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        label: Text("Quantity"),
                      ),
                      initialValue: qtyVal.toString(),
                      validator: (value) {
                        if (value == null || value.isEmpty || int.tryParse(value) == null || int.tryParse(value)! <= 0) {
                          return "Must be a valid, positive number";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        qtyVal = int.parse(value!);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField(
                      value: selectedCategory,
                      items: [
                        for (final category in categories.entries)
                          DropdownMenuItem(
                            value: category.value,
                            child: Row(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(color: category.value.color),
                                ),
                                const SizedBox(width: 6),
                                Text(category.value.title),
                              ],
                            ),
                          ),
                      ],
                      onChanged: ((value) {
                        if (value == null) {
                          return;
                        } else {
                          setState(() {
                            // print(_nameController);
                            selectedCategory = value;
                            // print(_selectedCategory);
                          });
                        }
                      }),
                      // onSaved: (value){
                      //   _s
                      // },
                    ),
                  )
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      _formKey.currentState!.reset();
                    },
                    child: const Text("Clear"),
                  ),
                  ElevatedButton(
                    onPressed: _saveItem,
                    child: const Text("Add Item"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
