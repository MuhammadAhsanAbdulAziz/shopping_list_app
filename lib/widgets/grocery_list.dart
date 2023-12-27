import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list_app/providers/grocery_provider.dart';
import 'package:shopping_list_app/widgets/grocery_list_item.dart';

class GroceryList extends ConsumerWidget {
  const GroceryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groceryList = ref.watch(groceryProvider);
    Widget content = ListView.builder(
      itemCount: groceryList.length,
      itemBuilder: (context, index) => Dismissible(
          background: Container(
            color: Theme.of(context).colorScheme.error,
            margin: Theme.of(context).cardTheme.margin,
          ),
          key: ValueKey(groceryList[index]),
          onDismissed: (direction) {
            ref
                .read(groceryProvider.notifier)
                .removeGrocery(groceryList[index]);
          },
          child: GroceryListItem(
            groceryItemModel: groceryList[index],
          )),
    );
    if (groceryList.isEmpty) {
      content = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Uh uh Nothing to show.",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Try adding some groceries"),
          ],
        ),
      );
    }
    return content;
  }
}
