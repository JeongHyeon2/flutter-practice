import 'package:json_annotation/json_annotation.dart';
import 'package:middle_class/common/model/model_with_id.dart';
import 'package:middle_class/common/utils/data_utils.dart';
import 'package:middle_class/restaurant/model/restaurant_model.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel implements IModelWithId {
  @override
  final String id;
  final String name;
  final String detail;
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String imgUrl;
  final int price;
  final RestaurantModel restaurant;

  ProductModel({
    required this.detail,
    required this.id,
    required this.imgUrl,
    required this.name,
    required this.price,
    required this.restaurant,
  });
  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}
