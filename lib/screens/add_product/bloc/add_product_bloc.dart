import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:project/network_utils/dio_helper.dart';
import 'package:project/network_utils/end_points.dart';
import 'package:project/screens/add_product/add_prodduct_model.dart';

part 'add_product_event.dart';

part 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductStates> {
  AddProductModel addProductModel;
  DioHelper dioHelper;

  AddProductBloc({@required this.dioHelper}) : super(AddProductInitialState());
  static String errorState;

  void useAddProduct({
    @required var name,
    @required var category,
    //  var contact,
    @required var quantity,
    @required var price,
    @required var expiry_date,
    @required var expiry_date_f,
    @required var expiry_date_s,
    @required var expiry_date_t,
    @required var price1,
    @required var price2,
    @required var price3,
    @required var image,
  }) async {
    emit(AddProductLoadingState());

    print(
        "name=$name,category=$category,quantity=$quantity,  price=$price, expiry_date_f=$expiry_date_f, expiry_date_s=$expiry_date_s, expiry_date_t=$expiry_date_t, price1=$price1,price2=$price2, price3=$price3 photo= $image");
    String imageName = image.path.split('/').last;
    print("imageName==$imageName");
    print("image path= ${image.path}");
    var formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(image.path, filename: imageName),
      "category_id": category,
      "name": name,
      "main_price": price,
      "price1": price1,
      "date1": expiry_date_f,
      "price2": price2,
      "end_date": expiry_date,
      "date2": expiry_date_s,
      "price3": price3,
      "date3": expiry_date_t,
      "quantity": quantity,
    });


    DioHelper.postData(data: formData, url: ADD_PRODUCT, token: token)
        .then((value) {
      print(value.statusCode);

      addProductModel = AddProductModel.fromJson(value.data);

      emit(AddProductSuccessState(addProductModel));
    }).catchError((error) {
      if (error.toString().contains('422')) {
        errorState = 'The name has already been taken.';

        emit(AddProductErrorState(errorState));
      }
    });
  }
}
