// ignore_for_file: constant_identifier_names

class FeatureModel {
  FeatureModel({
    required this.id,
    required this.name,
    required this.image,
    required this.widgetId,
  });

  int id;
  String name;
  String image;
  String widgetId;

  factory FeatureModel.fromMap(Map<String, dynamic> json) => FeatureModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        widgetId: json["widget_id"],
      );
}

/// this enum contain all features widgetIds
/// this values must'nt be changed
enum FeatureWidgetId {
  restaurant,
  explore,
  stores,
  delivery_companies,
  productive_families,
  cafes,
  pharmacies,
}
