import 'package:dio/dio.dart' hide Headers;
import 'package:middle_class/common/const/data.dart';
import 'package:middle_class/common/dio/dio.dart';
import 'package:middle_class/common/model/cursor_pagination_model.dart';
import 'package:middle_class/common/model/pagination_params.dart';
import 'package:middle_class/common/repository/base_pagination_repository.dart';
import 'package:middle_class/rating/model/rating_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
part 'restaurant_rating_repository.g.dart';

final restaruantRatingRepositoryProvider =
    Provider.family<RestaruantRatingRepository, String>((ref, id) {
  final dio = ref.watch(dioProvider);
  return RestaruantRatingRepository(dio,
      baseUrl: '$smIp/restaurant/$id/rating');
});

@RestApi()
abstract class RestaruantRatingRepository
    implements IBasePaginationRepository<RatingModel> {
  factory RestaruantRatingRepository(Dio dio, {String baseUrl}) =
      _RestaruantRatingRepository;

  @override
  @GET("/")
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPagination<RatingModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });
}
