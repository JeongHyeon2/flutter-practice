import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:middle_class/common/const/data.dart';
import 'package:middle_class/common/dio/dio.dart';
import 'package:middle_class/common/layout/default_layout.dart';
import 'package:middle_class/product/product_card.dart';
import 'package:middle_class/restaurant/component/restaurant_card.dart';
import 'package:middle_class/restaurant/model/restaurant_detail_model.dart';
import 'package:middle_class/restaurant/repository/restaurant_repository.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final String id;
  const RestaurantDetailScreen({
    required this.id,
    super.key,
  });
  Future<RestaurantDetailModel> getRestaurantDetail() async {
    final dio = Dio();
    dio.interceptors.add(
      CustomInterceptor(
        storage: storage,
      ),
    );

    final repository = RestaurantRepository(dio, baseUrl: "$smIp/restaurant");
    return repository.getRestaurantDetail(id: id);
  }

  @override
  Widget build(BuildContext context) {
    String n = "불타는 떡볶이";
    return DefaultLayout(
      title: n,
      child: FutureBuilder<RestaurantDetailModel>(
        future: getRestaurantDetail(),
        builder: (context, AsyncSnapshot<RestaurantDetailModel> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return CustomScrollView(
            slivers: [
              renderTop(model: snapshot.data!),
              renderLabel(),
              renderProduct(
                products: snapshot.data!.products,
              ),
            ],
          );
        },
      ),
    );
  }

  SliverPadding renderLabel() {
    return const SliverPadding(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      sliver: SliverToBoxAdapter(
        child: Text(
          "메뉴",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  SliverPadding renderProduct(
      {required List<RestaurantProductModel> products}) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final model = products[index];
            return Padding(
              padding: const EdgeInsets.only(
                top: 16,
              ),
              child: ProductCard.fromModel(
                model: model,
              ),
            );
          },
          childCount: products.length,
        ),
      ),
    );
  }

  SliverToBoxAdapter renderTop({
    required RestaurantDetailModel model,
  }) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          RestaurantCard.fromModel(
            isDetail: true,
            model: model,
          ),
        ],
      ),
    );
  }
}
