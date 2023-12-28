import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list_app/data/categories.dart';
import 'package:shopping_list_app/models/grocery_item_model.dart';
import 'package:http/http.dart' as http;

class GroceryNotifier extends StateNotifier<List<GroceryItemModel>> {
  GroceryNotifier() : super([]);

  var isLoading = true;
  String? error;

  void addGrocery(GroceryItemModel groceryItemModel) {
    state = [...state, groceryItemModel];
  }

  void removeGrocery(GroceryItemModel groceryItemModel) {}

  void deleteData(GroceryItemModel groceryItemModel) async {
    final index = state.indexOf(groceryItemModel);
    state =
        state.where((grocery) => grocery.id != groceryItemModel.id).toList();
    var url = Uri.https(
        'shopping-list-app-flutte-f2675-default-rtdb.firebaseio.com',
        'shopping-list/${groceryItemModel.id}.json');
    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      state.insert(index, groceryItemModel);
      state = [...state];
    }
  }

  void loadData() async {
    var url = Uri.https(
        'shopping-list-app-flutte-f2675-default-rtdb.firebaseio.com',
        'shopping-list.json');
    try {
      // Set the loading state to true
      isLoading = true;

      final response = await http.get(url);
      Map<String, dynamic> listData = {};
      if (response.body != "null") {
        listData = json.decode(response.body);
        for (final item in listData.entries) {
          final category = categories.entries
              .firstWhere(
                  (element) => element.value.title == item.value['category'])
              .value;
          GroceryItemModel grocery = GroceryItemModel(
              id: item.key,
              name: item.value['name'],
              quantity: item.value['quantity'],
              category: category);

          // Check if grocery is not already in the list
          if (!state.any((element) => element.id == grocery.id)) {
            state = [...state, grocery];
          }
        }
      }
    } catch (e) {
      error = "Error fetching results. Try again later";
    } finally {
      // Set the loading state to false in a finally block to ensure it happens even if there's an exception
      isLoading = false;
      state = [...state];
    }
  }
}

final groceryProvider =
    StateNotifierProvider<GroceryNotifier, List<GroceryItemModel>>(
        (ref) => GroceryNotifier());
