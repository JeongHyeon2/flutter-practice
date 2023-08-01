import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/model/shopping_item_model.dart';

final selectProvider = StateNotifierProvider<SelectNotifier, ShoppingItemModel>(
    (ref) => SelectNotifier());

class SelectNotifier extends StateNotifier<ShoppingItemModel> {
  SelectNotifier()
      : super(ShoppingItemModel(
          name: "name1",
          quantity: 3,
          hasBought: false,
          isSpicy: true,
        ));

  void toggleHasBought() => state = state.copyWith(hasBought: !state.hasBought);

  void toggleIsSpicy() => state = state.copyWith(isSpicy: !state.isSpicy);
}
