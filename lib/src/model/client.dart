import 'dart:convert';

extension ClientFunctions on Client {
  String get name => '${firstName ?? ''} ${lastName ?? ''}'.trim();
}

class Client {
  Client({
    required this.id,
    required this.avatar,
    required this.lang,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.gender,
    required this.birthday,
    required this.calendarType,
    required this.token,
  });

  int id;
  String? avatar;
  String lang;
  String? firstName;
  String? lastName;
  String phone;
  String? email;
  String? gender;
  String? birthday;
  String? calendarType;
  String token;

  factory Client.fromJson(String str) => Client.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Client.fromMap(Map<String, dynamic> json) => Client(
        id: json["id"],
        avatar: json["avatar"],
        lang: json["lang"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
        email: json["email"],
        gender: json["gender"],
        birthday: json["birthday"],
        calendarType: json["calendar_type"],
        token: json["token"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "avatar": avatar,
        "lang": lang,
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "email": email,
        "gender": gender,
        "birthday": birthday,
        "calendar_type": calendarType,
        "token": token,
      };
}
