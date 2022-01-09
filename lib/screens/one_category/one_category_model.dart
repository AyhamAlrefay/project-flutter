class OneCategoryModel {
  int id;
  String name;
  OneCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}