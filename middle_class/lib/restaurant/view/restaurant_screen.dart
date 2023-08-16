import 'package:middle_class/common/const/data.dart';
import 'package:middle_class/common/dio/dio.dart';
import 'package:middle_class/restaurant/component/restaurant_card.dart';
import 'package:middle_class/restaurant/model/restaurant_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:middle_class/restaurant/repository/restaurant_repository.dart';
import 'package:middle_class/restaurant/view/restaruant_detail_screen.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  Future<List<RestaurantModel>> paginateRestaurant() async {
    final dio = Dio();
    dio.interceptors.add(CustomInterceptor(
      storage: storage,
    ));

    final resp =
        await RestaurantRepository(dio, baseUrl: "$smIp/restaurant").paginate();

    return resp.data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: FutureBuilder<List<RestaurantModel>>(
              future: paginateRestaurant(),
              builder:
                  (context, AsyncSnapshot<List<RestaurantModel>> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.separated(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) {
                    final pItem = snapshot.data![index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => RestaurantDetailScreen(
                              id: pItem.id,
                            ),
                          ),
                        );
                      },
                      child: RestaurantCard.fromModel(
                        model: pItem,
                      ),
                    );
                  },
                  separatorBuilder: (_, index) {
                    return const SizedBox(height: 16.0);
                  },
                );
              },
            )),
      ),
    );
  }
}
