import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list_app/models/grocery_item_model.dart';

class GroceryNotifier extends StateNotifier<List<GroceryItemModel>> {
  GroceryNotifier() : super([]);

  void addGrocery(GroceryItemModel groceryItemModel) {
    state = [...state, groceryItemModel];
  }
  void removeGrocery(GroceryItemModel groceryItemModel) {
      state = state.where((grocery) => grocery.id != groceryItemModel.id).toList();
    
  }
}

final groceryProvider =
    StateNotifierProvider<GroceryNotifier, List<GroceryItemModel>>(
        (ref) => GroceryNotifier());
