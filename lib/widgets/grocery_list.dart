import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list_app/providers/grocery_provider.dart';
import 'package:shopping_list_app/widgets/grocery_list_item.dart';

class GroceryList extends ConsumerStatefulWidget {
  const GroceryList({super.key});

  @override
  ConsumerState<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends ConsumerState<GroceryList> {
  @override
  void initState() {
    super.initState();
    ref.read(groceryProvider.notifier).loadData();
  }

  @override
  Widget build(BuildContext context) {
    final groceryList = ref.watch(groceryProvider);
    final isLoading = ref.watch(groceryProvider.notifier).isLoading;
    Widget content = Center(
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
    if (isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (groceryList.isNotEmpty) {
      content = ListView.builder(
        itemCount: groceryList.length,
        itemBuilder: (context, index) => Dismissible(
            background: Container(
              color: Theme.of(context).colorScheme.error,
              margin: Theme.of(context).cardTheme.margin,
            ),
            key: ValueKey(groceryList[index].id),
            onDismissed: (direction) {
              
              ref
                  .read(groceryProvider.notifier)
                  .deleteData(groceryList[index]);
            },
            child: GroceryListItem(
              groceryItemModel: groceryList[index],
            )),
      );
    }
    if(ref.watch(groceryProvider.notifier).error != null){
      content = Center(child: Text(ref.watch(groceryProvider.notifier).error!),);
    }
    return content;
  }
}
