import 'package:json_annotation/json_annotation.dart';

part 'patch_basket_body.g.dart';

@JsonSerializable()
class PatchBasektBody {
  final List<PatchBasektBodyBasket> basket;

  PatchBasektBody({
    required this.basket,
  });

  Map<String, dynamic> toJson() => _$PatchBasektBodyToJson(this);
}

@JsonSerializable()
class PatchBasektBodyBasket {
  final String productId;
  final int count;
  PatchBasektBodyBasket({required this.count, required this.productId});

  Map<String, dynamic> toJson() => _$PatchBasektBodyBasketToJson(this);

  factory PatchBasektBodyBasket.fromJson(Map<String, dynamic> json) =>
      _$PatchBasektBodyBasketFromJson(json);
}
