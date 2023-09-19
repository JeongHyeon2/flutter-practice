import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:middle_class/common/const/colors.dart';
import 'package:middle_class/product/model/product_model.dart';
import 'package:middle_class/restaurant/model/restaurant_detail_model.dart';
import 'package:middle_class/user/provider/basket_provider.dart';

class ProductCard extends ConsumerWidget {
  final String id;
  final Image image;
  final String name;
  final String detail;
  final int price;
  final VoidCallback? onSubtract;
  final VoidCallback? onAdd;
  const ProductCard({
    super.key,
    required this.image,
    required this.detail,
    required this.name,
    required this.price,
    this.onAdd,
    this.onSubtract,
    required this.id,
  });
  factory ProductCard.fromProductModel({
    required ProductModel model,
    final VoidCallback? onSubtract,
    final VoidCallback? onAdd,
  }) {
    return ProductCard(
      image: Image.network(
        model.imgUrl,
        width: 110,
        height: 110,
        fit: BoxFit.cover,
      ),
      id: model.id,
      detail: model.detail,
      name: model.name,
      onAdd: onAdd,
      onSubtract: onSubtract,
      price: model.price,
    );
  }

  factory ProductCard.fromRestaurantProductModel({
    required RestaurantProductModel model,
    VoidCallback? onSubtract,
    VoidCallback? onAdd,
  }) {
    return ProductCard(
      id: model.id,
      image: Image.network(
        model.imgUrl,
        width: 110,
        height: 110,
        fit: BoxFit.cover,
      ),
      detail: model.detail,
      name: model.name,
      price: model.price,
      onAdd: onAdd,
      onSubtract: onSubtract,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basekt = ref.watch(basketProvider);
    // 가장 큰 위젯의 높이를 따라 다른 위젯도 커짐
    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: image,
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      detail,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: BODY_TEXT_COLOR,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "￦$price",
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: PRIMARY_COLOR,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (onSubtract != null && onAdd != null)
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                        ),
                        child: _Footer(
                          total: (basekt
                                      .firstWhere(
                                          (element) => element.product.id == id)
                                      .count *
                                  basekt
                                      .firstWhere(
                                          (element) => element.product.id == id)
                                      .product
                                      .price)
                              .toString(),
                          count: basekt
                              .firstWhere((element) => element.product.id == id)
                              .count,
                          onAdd: onAdd!,
                          onSubtract: onSubtract!,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  final String total;
  final int count;
  final VoidCallback onSubtract;
  final VoidCallback onAdd;
  const _Footer({
    super.key,
    required this.total,
    required this.count,
    required this.onAdd,
    required this.onSubtract,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            '총액 ￦$total',
            style: const TextStyle(
              color: PRIMARY_COLOR,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Row(
          children: [
            renderButton(
              icon: Icons.remove,
              onTap: onSubtract,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              count.toString(),
              style: const TextStyle(
                color: PRIMARY_COLOR,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            renderButton(
              icon: Icons.add,
              onTap: onAdd,
            ),
          ],
        ),
      ],
    );
  }

  Widget renderButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: PRIMARY_COLOR,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Icon(
          icon,
          color: PRIMARY_COLOR,
        ),
      ),
    );
  }
}
