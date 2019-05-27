import 'package:json_annotation/json_annotation.dart';

part 'NotificationData.g.dart';

@JsonSerializable()
class NotificationData {
  int id;
  String author;
  DateTime startDate;
  DateTime endDate;
  String text;

  NotificationData({
    this.author,
    this.endDate,
    this.id,
    this.startDate,
    this.text
  });

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case User.
  factory NotificationData.fromJson(Map<String, dynamic> json) => _$NotificationDataFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$NotificationDataToJson(this);
}