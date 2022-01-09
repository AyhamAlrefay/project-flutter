class CommentsModel {
  Data data;
  CommentsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

}

class Data {
  List<Data> data;

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }
}

class Data1 {
  int id;
  String body;
  Owner owner;

  Data1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
  }

}

class Owner {
  String name;

  Owner.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
}
