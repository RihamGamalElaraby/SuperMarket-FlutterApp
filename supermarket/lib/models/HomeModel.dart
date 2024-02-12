class HomeModel {
  bool? status;
  HomeDataModel? data;

  HomeModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromjson(json['data']);
  }
}

class HomeDataModel {
  List<bannerModel>? banners = [];
  List<productModel>? products = [];

  HomeDataModel.fromjson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      json['banners'].forEach((element) {
        banners!.add(bannerModel.fromjson(element));
      });
    }
    if (json['products'] != null) {
      json['products'].forEach((element) {
        products!.add(productModel.fromjson(element));
      });
    }
  }
}

class bannerModel {
  int? id;
  String? image;

  bannerModel.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class productModel {
  int? id;
  dynamic? price;
  dynamic? old_price;
  dynamic? discount;
  String? image;
  String? name;
  bool? in_favourites;
  bool? in_cart;

  productModel.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    in_favourites = json['in_favourites'];
    in_cart = json['in_cart'];
  }
}
