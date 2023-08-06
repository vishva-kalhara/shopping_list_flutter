import 'package:flutter/material.dart';
import 'package:shopping_list/models/categories.dart';

class GroceryItemWidget extends StatelessWidget {
  const GroceryItemWidget({super.key, required this.id, required this.name, required this.quantity, required this.category});

  final String id;
  final String name;
  final int quantity;
  final Category category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: category.color,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: 48,
                    height: 48,
                  ),
                  const SizedBox(width: 24),
                  Text(
                    name,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                  )
                ],
              ),
              Text(
                quantity.toString(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
