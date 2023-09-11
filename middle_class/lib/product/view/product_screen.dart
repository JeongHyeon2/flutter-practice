import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:middle_class/common/component/pagination_list_view.dart';
import 'package:middle_class/product/component/product_card.dart';
import 'package:middle_class/product/model/product_model.dart';
import 'package:middle_class/product/provider/product_provider.dart';
import 'package:middle_class/restaurant/view/restaruant_detail_screen.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginationListView<ProductModel>(
      provider: productProvider,
      itemBuilder: <ProductModel>(_, index, model) {
        return GestureDetector(
          onTap: () {
            context.goNamed(RestaurantDetailScreen.routeName, pathParameters: {
              'rid': model.restaurant.id,
            });
          },
          child: ProductCard.fromProductModel(
            model: model,
          ),
        );
      },
    );
  }
}
