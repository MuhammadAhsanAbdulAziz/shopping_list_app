import 'package:flutter/material.dart';
import 'package:shopping_list_app/models/grocery_item_model.dart';

class GroceryListItem extends StatelessWidget {
  const GroceryListItem({required this.groceryItemModel, super.key});

  final GroceryItemModel groceryItemModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.all(14),
          width: 25,
          height: 25,
          color: groceryItemModel.category.color,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          groceryItemModel.name,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 17),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            groceryItemModel.quantity.toString(),
          ),
        ),
      ],
    );
  }
}
