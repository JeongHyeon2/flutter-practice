import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:middle_class/common/const/data.dart';
import 'package:middle_class/common/dio/dio.dart';
import 'package:middle_class/order/model/order_model.dart';
import 'package:middle_class/order/model/post_order_body.dart';
import 'package:retrofit/retrofit.dart';

part 'order_repository.g.dart';

final orderRepositoryProvider = Provider(
  (ref) {
    final dio = ref.watch(dioProvider);
    return OrderRepository(
      dio,
      baseUrl: '$smIp/order',
    );
  },
);

@RestApi()
abstract class OrderRepository {
  factory OrderRepository(Dio dio, {String baseUrl}) = _OrderRepository;

  @POST('/')
  @Headers({
    'accessToken': 'true',
  })
  Future<OrderModel> postOrder({
    @Body() required PostOrderBody body,
  });
}
