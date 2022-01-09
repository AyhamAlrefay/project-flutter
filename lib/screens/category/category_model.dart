class CategoryModel {

  List<Data> data;
  CategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }
}

class Data {
  int id;
  String name;
  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}