class EditProductModel {
  var status;
  var msg;

  EditProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
  }
}