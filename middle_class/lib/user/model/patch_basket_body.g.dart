// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patch_basket_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatchBasektBody _$PatchBasektBodyFromJson(Map<String, dynamic> json) =>
    PatchBasektBody(
      basket: (json['basket'] as List<dynamic>)
          .map((e) => PatchBasektBodyBasket.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PatchBasektBodyToJson(PatchBasektBody instance) =>
    <String, dynamic>{
      'basket': instance.basket,
    };

PatchBasektBodyBasket _$PatchBasektBodyBasketFromJson(
        Map<String, dynamic> json) =>
    PatchBasektBodyBasket(
      count: json['count'] as int,
      productId: json['productId'] as String,
    );

Map<String, dynamic> _$PatchBasektBodyBasketToJson(
        PatchBasektBodyBasket instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'count': instance.count,
    };
