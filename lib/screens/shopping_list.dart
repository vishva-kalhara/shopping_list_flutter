import 'package:flutter/material.dart';
import 'package:shopping_list/models/categories.dart';
import 'package:shopping_list/models/grocery_items.dart';
// import 'package:shopping_list/models/grocery_items.dart';
import 'package:shopping_list/widgets/grocery_item.dart';
import 'package:shopping_list/Data/dummy_items.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({super.key});

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Groceries"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              for (final item in groceryItems)
                GroceryItemWidget(
                  id: item.id,
                  name: item.name,
                  quantity: item.quantity,
                  category: item.category,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
