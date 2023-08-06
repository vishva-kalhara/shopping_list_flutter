import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_items.dart';
// import 'package:shopping_list/models/categories.dart';
// import 'package:shopping_list/models/grocery_items.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: groceryItems.length,
          itemBuilder: (context, index) {
            return GroceryItemWidget(
              id: groceryItems[index].id,
              name: groceryItems[index].name,
              quantity: groceryItems[index].quantity,
              category: groceryItems[index].category,
            );
          },
        ),
      ),
    );
  }
}
