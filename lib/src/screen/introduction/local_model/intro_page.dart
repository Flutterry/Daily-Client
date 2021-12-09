class IntroPage {
  IntroPage({
    required this.image,
    required this.title,
    required this.description,
  });

  String image;
  String title;
  String description;

  factory IntroPage.fromMap(Map<String, dynamic> json) => IntroPage(
        image: json["image"],
        title: json["title"],
        description: json["description"],
      );
}
