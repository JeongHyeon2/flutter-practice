import 'package:json_annotation/json_annotation.dart';
import 'package:middle_class/common/model/model_with_id.dart';
import 'package:middle_class/common/utils/data_utils.dart';
import 'package:middle_class/user/model/user_model.dart';

part 'rating_model.g.dart';

@JsonSerializable()
class RatingModel implements IModelWithId {
  @override
  final String id;
  final UserModel user;
  final int rating;
  final String content;
  @JsonKey(
    fromJson: DataUtils.listPathsToUrls,
  )
  final List<String> imgUrls;

  RatingModel({
    required this.content,
    required this.id,
    required this.imgUrls,
    required this.rating,
    required this.user,
  });
  factory RatingModel.fromJson(Map<String, dynamic> json) =>
      _$RatingModelFromJson(json);
}
