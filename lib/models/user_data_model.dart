class UserDataModel {
  int id;
  String name;
  String email;
  String phone;
  String image;
  String points;
  String credit;
  String token;

  UserDataModel.fromJson(Map<String, dynamic> jsnon) {
    id = jsnon['id'];
    name = jsnon['name'].toString();
    email = jsnon['email'].toString();
    phone = jsnon['phone'].toString();
    image = jsnon['image'].toString();
    points = jsnon['points'].toString();
    credit = jsnon['credit'].toString();
    token = jsnon['token'].toString();
  }
}
