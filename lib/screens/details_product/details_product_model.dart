class DetailsProductModel {
  dynamic id;
  dynamic categoryId;
  dynamic ownerId;
  dynamic name;
  dynamic mainPrice;
  dynamic currentPrice;
  dynamic endDate;
  dynamic quantity;
  dynamic reacts;
  dynamic views;
  dynamic image;
  dynamic ownerPhoneNum;

  DetailsProductModel.fromJson(dynamic json) {
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