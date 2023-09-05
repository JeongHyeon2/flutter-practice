import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:middle_class/common/model/cursor_pagination_model.dart';
import 'package:middle_class/common/provider/pagination_provider.dart';
import 'package:middle_class/rating/model/rating_model.dart';
import 'package:middle_class/restaurant/repository/restaurant_rating_repository.dart';

final restaurantRatingProvider = StateNotifierProvider.family<
    RestaurantRatingStateNotifier, CursorPaginationBase, String>((ref, id) {
  final repo = ref.watch(restaruantRatingRepositoryProvider(id));

  return RestaurantRatingStateNotifier(repository: repo);
});

class RestaurantRatingStateNotifier
    extends PaginationProvider<RatingModel, RestaruantRatingRepository> {
  RestaurantRatingStateNotifier({
    required super.repository,
  });
}
