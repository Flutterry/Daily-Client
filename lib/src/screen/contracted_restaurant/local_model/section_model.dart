class SectionModel {
  SectionModel({
    required this.id,
    required this.name,
    required this.products,
  });

  int id;
  String name;
  List<ProductModel> products;

  factory SectionModel.fromMap(Map<String, dynamic> json) => SectionModel(
        id: json["id"],
        name: json["name"],
        products: List<ProductModel>.from(
          json["products"].map((x) => ProductModel.fromMap(x)),
        ),
      );
}

class ProductModel {
  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
  });

  int id;
  String name;
  String description;
  String image;
  int price;

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        price: json["price"],
      );
}
