class LocationModel {
  LocationModel({
    required this.id,
    required this.lat,
    required this.lng,
    required this.label,
  });

  int id;
  num lat;
  num lng;
  String label;

  factory LocationModel.fromMap(Map<String, dynamic> json) => LocationModel(
        id: json["id"],
        lat: num.parse(json["lat"]),
        lng: num.parse(json["lng"]),
        label: json["label"],
      );
}
