class LikesModel {
  bool status;
  String msg;
  LikesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
  }

}