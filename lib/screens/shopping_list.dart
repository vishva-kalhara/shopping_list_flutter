import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list/Data/categories.dart';
import 'dart:convert';

import 'package:shopping_list/models/grocery_items.dart';
import 'package:shopping_list/widgets/grocery_item.dart';
import 'package:shopping_list/screens/new_item.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({super.key});

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  List<GroceryItem> _groceryItem = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void routeToAddItem() async {
    await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(builder: (ctx) => const AddItenScreen()),
    );
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.https("flutter-prep-ea807-default-rtdb.firebaseio.com", "shopping-list.json");
    final response = await http.get(url);
    final Map<String, dynamic> listData = await jsonDecode(response.body);
    final List<GroceryItem> _loadedItems = [];
    for (final item in listData.entries) {
      final cateegory = categories.entries
          .firstWhere(
            (element) => element.value.title == item.value['category'],
          )
          .value;
      _loadedItems.add(
        GroceryItem(
          id: item.key,
          name: item.value["name"],
          quantity: item.value["quantity"],
          category: cateegory,
        ),
      );
    }
    setState(() {
      _groceryItem = _loadedItems;
    });
    // print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: _groceryItem.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: ValueKey(_groceryItem[index].id),
          child: GroceryItemWidget(
            id: _groceryItem[index].id,
            name: _groceryItem[index].name,
            quantity: _groceryItem[index].quantity,
            category: _groceryItem[index].category,
          ),
          onDismissed: (item) {
            setState(() {
              _groceryItem.remove(_groceryItem[index]);
            });
          },
        );
      },
    );

    if (_groceryItem.isEmpty) {
      content = Center(
        child: Text(
          "Try Adding tems!",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Groceries"),
        actions: [
          IconButton(
            onPressed: _loadItems,
            icon: const Icon(Icons.refresh_rounded),
          ),
          IconButton(
            onPressed: routeToAddItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: content,
      ),
    );
  }
}
