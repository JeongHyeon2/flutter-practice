import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:middle_class/product/model/product_model.dart';
import 'package:middle_class/user/model/basket_item_model.dart';
import 'package:collection/collection.dart';
import 'package:middle_class/user/model/patch_basket_body.dart';
import 'package:middle_class/user/repository/user_me_repository.dart';

final basketProvider =
    StateNotifierProvider<BasketProvider, List<BasketItemModel>>(
  (ref) {
    final repository = ref.watch(userMeRepositoryProvider);

    return BasketProvider(
      repository: repository,
    );
  },
);

class BasketProvider extends StateNotifier<List<BasketItemModel>> {
  final UserMeRepository repository;
  final updateBasketDebounce = Debouncer(
    const Duration(
      seconds: 1,
    ),
    initialValue: null,
    checkEquality: false,
  );
  BasketProvider({
    required this.repository,
  }) : super([]) {
    updateBasketDebounce.values.listen(
      (event) {
        patchBasekt();
      },
    );
  }

  Future<void> patchBasekt() async {
    await repository.patchBasket(
      body: PatchBasektBody(
        basket: state
            .map(
              (e) => PatchBasektBodyBasket(
                  count: e.count, productId: e.product.id),
            )
            .toList(),
      ),
    );
  }

  Future<void> addToBasket({
    required ProductModel product,
  }) async {
    final exists =
        state.firstWhereOrNull((element) => element.product.id == product.id) !=
            null;
    if (exists) {
      state = state
          .map(
            (e) => e.product.id == product.id
                ? e.copyWith(
                    count: e.count + 1,
                  )
                : e,
          )
          .toList();
    } else {
      state = [
        ...state,
        BasketItemModel(count: 1, product: product),
      ];
    }
    updateBasketDebounce.setValue(null);
  }

  Future<void> removeFromBasket({
    required ProductModel product,
    bool isDelete = false,
  }) async {
    final exists =
        state.firstWhereOrNull((element) => element.product.id == product.id) !=
            null;
    if (!exists) {
      return;
    }
    final existingProduct = state.firstWhere(
      (element) => element.product.id == product.id,
    );

    if (existingProduct.count == 1 || isDelete) {
      state = state
          .where(
            (element) => element.product.id != product.id,
          )
          .toList();
    } else {
      state = state
          .map((e) => e.product.id == product.id
              ? e.copyWith(
                  count: e.count - 1,
                )
              : e)
          .toList();
    }
    updateBasketDebounce.setValue(null);
  }
}
