class AboutModel {
  AboutModel({
    required this.id,
    required this.title,
    required this.body,
  });

  int id;
  String title;
  String body;

  factory AboutModel.fromMap(Map<String, dynamic> json) => AboutModel(
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );
}
