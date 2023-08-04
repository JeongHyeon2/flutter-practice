import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'example.g.dart';

@RestApi(baseUrl: "http://localhost:3000/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/cats")
  Future<List<Task>> getTasks();

  @POST("/cats")
  Future<List<Task>> post(@Body() Task task);
}

@JsonSerializable()
class Task {
  DateTime? date;
  String? startTime;
  String? scheduledTime;
  bool? canGeneralUser;

  Task({this.date, this.startTime, this.scheduledTime, this.canGeneralUser});

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
