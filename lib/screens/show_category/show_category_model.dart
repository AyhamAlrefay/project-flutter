class ShowCategoryModel {
  int id;
  int categoryId;
  int ownerId;
  String name;
  int mainPrice;
  int currentPrice;
  String endDate;
  int quantity;
  int reacts;
  int views;
  String image;
  String ownerPhoneNum;

  ShowCategoryModel.fromJson(Map<String, dynamic> json) {
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