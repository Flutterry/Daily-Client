extension ProductModelFunctions on ProductModel {
  double totalPrice(int quantity) {
    if (attributes.where((x) => x.selected).isEmpty) {
      attributes.first.selected = true;
    }
    return quantity * (_selectedExtrasPrice + _selectedSizePrice);
  }

  double get _selectedExtrasPrice {
    double price = 0.0;
    extras.where((x) => x.selected).forEach((y) => price += y.price);
    return price;
  }

  double get _selectedSizePrice => double.parse(
        attributes.where((x) => x.selected).first.price.toStringAsFixed(2),
      );
}

class ProductModel {
  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.extras,
    required this.attributes,
  });

  int id;
  String name;
  String description;
  String image;
  List<_Attribute> extras;
  List<_Attribute> attributes;

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        description: json["description"] ?? '',
        image: json["image"],
        extras: List<_Attribute>.from(
          json["extras"].map((x) => _Attribute.fromMap(x)),
        ),
        attributes: List<_Attribute>.from(
          json["attributes"].map((x) => _Attribute.fromMap(x)),
        ),
      );
}

class _Attribute {
  _Attribute({
    required this.id,
    required this.name,
    required this.price,
    this.selected = false,
  });

  int id;
  String name;
  int price;
  bool selected;

  factory _Attribute.fromMap(Map<String, dynamic> json) => _Attribute(
        id: json["id"],
        name: json["name"],
        price: json["price"],
      );
}
