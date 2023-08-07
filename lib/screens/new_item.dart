import 'package:flutter/material.dart';
import 'package:shopping_list/Data/categories.dart';
// import 'package:shopping_list/Data/dummy_items.dart';
// import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/categories.dart';
import 'package:shopping_list/models/grocery_items.dart';

class AddItenScreen extends StatefulWidget {
  const AddItenScreen({
    super.key,
  });

  // final void Function(Map<Map, GroceryItem> res) onSendData;

  @override
  State<AddItenScreen> createState() => _AddItenScreenState();
}

class _AddItenScreenState extends State<AddItenScreen> {
  final _nameController = TextEditingController();
  final _qtyController = TextEditingController();
  var _selectedCategory = Categories.vegetables;

  void _passDataToMain() {
    Navigator.of(context).pop();
    // final result = {
    //   "id",
    //   _nameController.text,
    //   _qtyController.text,
    //   _selectedCategory,
    // };
    // widget.onSendData(result);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _qtyController.dispose();
    super.dispose();
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
                      initialValue: 1.toString(),
                      validator: (value) {
                        if (value == null || value.isEmpty || int.tryParse(value) == null || int.tryParse(value)! <= 0) {
                          return "Must be a valid, positive number";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField(
                        // value: _selectedCategory,
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
                              // _selectedCategory = value;
                              // print(_selectedCategory);
                            });
                          }
                        })),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: _passDataToMain,
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
