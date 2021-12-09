import 'package:easy_localization/easy_localization.dart';

extension CompanyModelFunctions on CompanyModel {
  String get prepareTime => tr(
        'common.prepareTime',
        args: [
          '${averagePreparationTime - 5 <= 0 ? averagePreparationTime : averagePreparationTime - 5} - ${averagePreparationTime + 10}'
        ],
      );

  //fixme
  bool get isOpen => true;
}

class CompanyModel {
  CompanyModel({
    required this.id,
    required this.name,
    required this.contracted,
    required this.address,
    required this.description,
    required this.averagePreparationTime,
    required this.avatar,
    required this.cover,
    required this.minimumPurchase,
    required this.distance,
    required this.rate,
    required this.deliveryPrice,
    required this.discount,
    required this.vat,
  });
  int id;
  String name;
  bool contracted;
  String address;
  String description;
  int averagePreparationTime;
  String avatar;
  String cover;
  String minimumPurchase;
  String distance;
  String rate;
  String deliveryPrice;
  String discount;
  num vat;

  factory CompanyModel.fromMap(Map<String, dynamic> json) => CompanyModel(
        id: json["id"],
        name: json["name"],
        contracted: json["contracted"] == 1,
        address: json["address"],
        description: json["description"] ?? '',
        averagePreparationTime: json["average_preparation_time"],
        avatar: json["avatar"],
        cover: json["cover"],
        minimumPurchase: (json["minimum_purchase"] ?? 0).toStringAsFixed(2),
        distance: json["distance"].toStringAsFixed(2),
        rate: json["rate"].toStringAsFixed(1),
        deliveryPrice: json["delivery_price"].toStringAsFixed(2),
        discount: json["discount"].toStringAsFixed(0),
        vat: json["VAT"] ?? 0,
      );
}
