class NameModel {
  String name;

  NameModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }}