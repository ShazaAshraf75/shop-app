class ShopRegisterModel {
  late bool? status;
  late String? message;
  late ShopRegisterDataModel? data;
  ShopRegisterModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json['data'] != null
        ? ShopRegisterDataModel.fromJson(json["data"])
        : null;
  }
}

class ShopRegisterDataModel {
  late String? name;
  late String? email;
  late String? phone;
  late String? token;
  late String? image;
  late int? id;

  ShopRegisterDataModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    email = json["email"];
    phone = json["phone"];
    id = json["id"];
    token = json["token"];
    image = json["image"];
  }
}
