import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:middle_class/common/model/cursor_pagination_model.dart';
import 'package:middle_class/common/provider/pagination_provider.dart';
import 'package:middle_class/restaurant/model/restaurant_model.dart';
import 'package:middle_class/restaurant/repository/restaurant_repository.dart';
import 'package:collection/collection.dart';

final restaurantDetailProvider =
    Provider.family<RestaurantModel?, String>((ref, id) {
  final state = ref.watch(restaurantProvider);
  if (state is! CursorPagination) {
    return null;
  }
  return state.data.firstWhereOrNull((element) => element.id == id);
});
final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>((ref) {
  final repository = ref.watch(restaurantRepositoryProvider);
  final notifier = RestaurantStateNotifier(repository: repository);
  return notifier;
});

class RestaurantStateNotifier
    extends PaginationProvider<RestaurantModel, RestaurantRepository> {
  RestaurantStateNotifier({
    required super.repository,
  });

  getDetail({
    required String id,
  }) async {
    // 데이터가 없는 상태 -> (CursorPagination이 아니라면) 데이터를 가져온다
    if (state is! CursorPagination) {
      await paginate();
    }

    if (state is! CursorPagination) {
      return;
    }

    final pState = state as CursorPagination;
    final resp = await repository.getRestaurantDetail(id: id);

    if (pState.data.where((element) => element.id == id).isEmpty) {
      state = pState.copyWith(
        data: <RestaurantModel>[
          ...pState.data,
          resp,
        ],
      );
    } else {
      state = pState.copyWith(
        data: pState.data
            .map<RestaurantModel>((e) => e.id == id ? resp : e)
            .toList(),
      );
    }
  }
}
