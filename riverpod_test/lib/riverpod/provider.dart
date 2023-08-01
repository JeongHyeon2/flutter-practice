import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/model/shopping_item_model.dart';
import 'package:riverpod_test/riverpod/state_notifier_provider.dart';

final filteredShoppingListProvider = Provider<List<ShoppingItemModel>>((ref) {
  final shoppingListState = ref.watch(shoppingListProvider);
  final filterState = ref.watch(filterProvider);
  print(filterState);
  switch(filterState) {
    case FilterState.all: return shoppingListState;
    case FilterState.spicy: return shoppingListState.where((element) => element.isSpicy).toList();
    case FilterState.notSpicy: return shoppingListState.where((element) => !element.isSpicy).toList();
  }
});

enum FilterState {
  notSpicy,
  spicy,
  all;
}

final filterProvider = StateProvider<FilterState>((ref) => FilterState.all);
