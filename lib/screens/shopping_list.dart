import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_items.dart';
// import 'package:shopping_list/models/grocery_items.dart';
// import 'package:shopping_list/models/categories.dart';
// import 'package:shopping_list/models/grocery_items.dart';
// import 'package:shopping_list/models/grocery_items.dart';
import 'package:shopping_list/widgets/grocery_item.dart';
import 'package:shopping_list/Data/dummy_items.dart';
import 'package:shopping_list/screens/new_item.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({super.key});

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  final List<GroceryItem> _groceryItem = [];

  void routeToAddItem() async {
    final result = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(builder: (ctx) => const AddItenScreen()),
    );
    if (result == null) return;
    setState(() {
      _groceryItem.add(result);
    });
    // print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Groceries"),
        actions: [IconButton(onPressed: routeToAddItem, icon: const Icon(Icons.add))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: _groceryItem.length,
          itemBuilder: (context, index) {
            return GroceryItemWidget(
              id: _groceryItem[index].id,
              name: _groceryItem[index].name,
              quantity: _groceryItem[index].quantity,
              category: _groceryItem[index].category,
            );
          },
        ),
      ),
    );
  }
}
