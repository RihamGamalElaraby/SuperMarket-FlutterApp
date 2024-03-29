class CategoriesModel {
  bool? status;
  CategoriesDataModel? data;

  CategoriesModel.fromJson(Map<String, dynamic>? json) {
    status = json?['status'];
    data = json != null ? CategoriesDataModel.fromJson(json['data']) : null;
  }
}

class CategoriesDataModel {
  int? current_page;
  List<DataModel>? data = [];
  CategoriesDataModel.fromJson(Map<String, dynamic>? json) {
    current_page = json?['current_page'];
    if (json?['data'] != null) {
      json!['data'].forEach((element) {
        data!.add(DataModel.fromJson(element));
      });
    }
  }
}

class DataModel {
  int? id;
  String? name;
  String? image;

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
