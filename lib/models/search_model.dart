class SearchModel {
  bool status;
  String message;
  List<DataModel> data = [];
  SearchModel(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    json['data']['data'].forEach((value) {
      data.add(DataModel(value));
    });
  }
}

class DataModel {
  int id;
  dynamic price;
  String image;
  String name;
  String description;
  bool inFavorites;
  bool inCart;
  DataModel(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
