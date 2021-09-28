class HomeModel {
  dynamic status;
  HomeDataModel data;
  HomeModel(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel(json['data']);
  }
}

class HomeDataModel {
  List<BannersModel> banners = [];
  List<ProductsModel> products = [];
  HomeDataModel(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(BannersModel(element));
    });
    json['products'].forEach((element) {
      products.add(ProductsModel(element));
    });
  }
}

class BannersModel {
  dynamic id;
  dynamic image;
  BannersModel(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductsModel {
  dynamic id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  dynamic image;
  dynamic name;
  bool in_favorites;
  dynamic in_cart;
  ProductsModel(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];
  }
}
