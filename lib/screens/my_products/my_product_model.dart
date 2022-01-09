class MyProductModel {
  var id;
  var categoryId;
  var ownerId;
  var name;
  var mainPrice;
  var currentPrice;
  var endDate;
  var quantity;
  var reacts;
  var views;
  var image;
  var ownerPhoneNum;

  MyProductModel.fromJson(dynamic json) {
    id = json['id'];
    categoryId = json['category_id'];
    ownerId = json['owner_id'];
    name = json['name'];
    mainPrice = json['main_price'];
    currentPrice = json['current_price'];
    endDate = json['end_date'];
    quantity = json['quantity'];
    reacts = json['reacts'];
    views = json['views'];
    image = json['image'];
    ownerPhoneNum = json['owner_phone_num'];
  }

}