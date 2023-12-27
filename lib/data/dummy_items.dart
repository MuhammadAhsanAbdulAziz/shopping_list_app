
import 'package:shopping_list_app/models/category_model.dart';
import 'package:shopping_list_app/models/grocery_item_model.dart';

import 'categories.dart';

final  groceryItemModels = [
  GroceryItemModel(
      id: 'a',
      name: 'Milk',
      quantity: 1,
      category: categories[Categories.dairy]!),
  GroceryItemModel(
      id: 'b',
      name: 'Bananas',
      quantity: 5,
      category: categories[Categories.fruit]!),
  GroceryItemModel(
      id: 'c',
      name: 'Beef Steak',
      quantity: 1,
      category: categories[Categories.carbs]!),
]; 