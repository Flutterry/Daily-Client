// import 'dart:convert';
// https://app.quicktype.io/

import 'package:easy_localization/easy_localization.dart';

extension CommentModelFunctions on CommentModel {
  String get date => DateFormat.yMEd().format(createdAt);
}

class CommentModel {
  CommentModel({
    required this.id,
    required this.body,
    required this.rate,
    required this.createdAt,
    required this.authorId,
    required this.name,
    required this.avatar,
  });

  int id;
  String body;
  num rate;
  DateTime createdAt;
  int authorId;
  String? name;
  String? avatar;

  factory CommentModel.fromMap(Map<String, dynamic> json) => CommentModel(
        id: json["id"],
        body: json["body"],
        rate: json["rate"],
        createdAt: DateTime.parse(json["created_at"]),
        authorId: json["author_id"],
        name: json["name"],
        avatar: json["avatar"],
      );
}
