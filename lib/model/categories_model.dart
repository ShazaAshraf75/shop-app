class CategoriesModel {
  late bool status;
  late CategoriesDataModel data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    data = CategoriesDataModel.fromJson(json["data"]);
  }
}

class CategoriesDataModel {
  late int currentPage;
  late List<DataModel> data;

  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json["current_page"];
    data = List.from(json["data"]).map((e) => DataModel.fromJson(e)).toList();
  }
}

class DataModel {
  late int id;
  late String name;
  late String image;

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    image = json["image"];
  }
}
