import 'package:flutter/material.dart';
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
      itemBuilder: <ProductModel>(context, index, model) {
        return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => RestaurantDetailScreen(
                    id: model.restaurant.id,
                  ),
                ),
              );
            },
            child: ProductCard.fromProductModel(model: model));
      },
    );
  }
}
