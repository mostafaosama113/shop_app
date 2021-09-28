class CategoriesModel {
  bool status;
  DataPage dataPage;

  CategoriesModel(Map<String, dynamic> json) {
    this.status = json['status'];
    this.dataPage = DataPage(json['data']);
  }
}

class DataPage {
  int currentPage;
  List<Data> data = [];
  DataPage(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((value) {
      data.add(Data(value));
    });
  }
}

class Data {
  int id;
  String name;
  String image;
  Data(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
