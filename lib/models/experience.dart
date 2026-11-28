import 'package:json_annotation/json_annotation.dart';

part 'experience.g.dart';

/// Experience data matching the Django REST Framework ExperienceSerializer.
@JsonSerializable(fieldRename: FieldRename.snake)
class Experience {
  const Experience({
    this.id,
    required this.title,
    required this.description,
    required this.category,
    this.thumbnail,
    this.startedAt,
    this.endedAt,
    this.starCount = 0,
    this.isStarred = false,
    this.starredByNames = '',
  });

  factory Experience.fromJson(Map<String, dynamic> json) =>
      _$ExperienceFromJson(json);

  @JsonKey(includeToJson: false)
  final String? id;
  final String title;
  final String description;
  final String category;
  @JsonKey(includeToJson: false)
  final DateTime? startedAt;
  final DateTime? endedAt;
  bool get isOngoing => endedAt == null;
  final String? thumbnail;
  @JsonKey(includeToJson: false)
  final int starCount;
  @JsonKey(includeToJson: false)
  final bool isStarred;
  @JsonKey(includeToJson: false)
  final String starredByNames;

  Map<String, dynamic> toJson() => _$ExperienceToJson(this);
}
