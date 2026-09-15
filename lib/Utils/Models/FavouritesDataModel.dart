class FavouritesDataModel {
  int? status;
  String? message;
  bool? favouritesStatus;
  int? favouritesCount;

  FavouritesDataModel(
      {this.status, this.message, this.favouritesStatus, this.favouritesCount});

  FavouritesDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    favouritesStatus = json['favourites_status'];
    favouritesCount = json['favourites_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['favourites_status'] = favouritesStatus;
    data['favourites_count'] = favouritesCount;
    return data;
  }
}
