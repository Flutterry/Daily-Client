import 'package:daily_client/src/application.dart';

class SectionModel {
  SectionModel({
    required this.id,
    required this.name,
    required this.image,
    required this.companies,
  });

  int id;
  String name;
  String image;
  List<CompanyModel> companies;

  factory SectionModel.fromMap(Map<String, dynamic> json) => SectionModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        companies: List<CompanyModel>.from(
          json["companies"].map((x) => CompanyModel.fromMap(x)),
        ),
      );
}
