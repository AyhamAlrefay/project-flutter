class ProfileModel {
  int id;
  String name;
  String email;
  String password;
  String phoneNum;
  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phoneNum = json['phone_num'];
  }
}