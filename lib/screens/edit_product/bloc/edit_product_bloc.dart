import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:project/network_utils/dio_helper.dart';
import 'package:project/network_utils/end_points.dart';
import 'package:project/screens/edit_product/edit_product_model.dart';

part 'edit_product_event.dart';

part 'edit_product_state.dart';

class EditProductBloc extends Bloc<EditProductEvent, EditProductStates> {
  EditProductBloc({@required DioHelper dioHelper})
      : super(EditProductInitialState());
  EditProductModel editProductModel;
  DioHelper dioHelper;

  void editProductFun({
   @required var idProduct,
    var name,
    var productId,
    var quantity,
    var price,
    var expiry_date_f,
    var expiry_date_s,
    var expiry_date_t,
    var price1,
    var price2,
    var price3,
    var image,
  })async {
    emit(EditProductLoadingState());

    String imageName=image==null?null:image.path.split('/').last;
    var formData=FormData.fromMap({
      'image':image==null?null:await MultipartFile.fromFile(image.path,filename: imageName),
      "name":name,
      "main_price":price,
      "price1":price1,
      "date1":expiry_date_f,
      "price2":price2,
      "date2":expiry_date_s,
      "price3":price3,
      "date3":expiry_date_t,
      "quantity":quantity,
    });

    DioHelper.postData(url: EDIT_PRODUCT+"$idProduct", data:formData ).then((value){

      editProductModel=EditProductModel.fromJson(value.data);
      emit(EditProductSuccessState(editProductModel));
    }).catchError((error){emit(EditProductErrorState(editProductModel));});
    
  }
}
