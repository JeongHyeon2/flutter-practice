import 'package:dio/dio.dart' hide Headers;
import 'package:middle_class/restaurant/model/restaurant_detail_model.dart';
import 'package:retrofit/retrofit.dart';

part 'restaurant_repository.g.dart';

@RestApi()
abstract class RestaurantRepository {
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  // @GET("/")
  // paginate();
  @GET("/{id}")
  @Headers({
    'authorization':
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3RAY29kZWZhY3RvcnkuYWkiLCJzdWIiOiJmNTViMzJkMi00ZDY4LTRjMWUtYTNjYS1kYTlkN2QwZDkyZTUiLCJ0eXBlIjoiYWNjZXNzIiwiaWF0IjoxNjkxOTk3MjE3LCJleHAiOjE2OTE5OTc1MTd9.GzexP4FY3z6OzRUQX60evC-TSeO5GYgSWbqpKz-9eqs'
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required id,
  });
}
