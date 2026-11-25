import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

/// Project data matching the Django REST Framework ProjectSerializer.
@JsonSerializable(fieldRename: FieldRename.snake)
class Project {
  const Project({
    this.id,
    required this.projectName,
    required this.projectDesc,
    required this.techStack,
    this.uploadedDate,
    this.thumbnail,
    this.projectLink,
    this.starCount = 0,
    this.isStarred = false,
    this.starredByNames = '',
  });

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  @JsonKey(includeToJson: false)
  final String? id;
  final String projectName;
  final String projectDesc;
  final String techStack;
  @JsonKey(includeToJson: false)
  final DateTime? uploadedDate;
  final String? thumbnail;
  final String? projectLink;
  @JsonKey(includeToJson: false)
  final int starCount;
  @JsonKey(includeToJson: false)
  final bool isStarred;
  @JsonKey(includeToJson: false)
  final String starredByNames;

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
