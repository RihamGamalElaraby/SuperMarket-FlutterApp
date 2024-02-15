class changeFavouriteModel {
  bool? status;
  String? message;

  changeFavouriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
