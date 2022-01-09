import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:project/network_utils/dio_helper.dart';
import 'package:project/screens/details_product/details_product_model.dart';
import 'package:project/network_utils/end_points.dart';
import 'package:project/screens/details_product/likes_Model.dart';
part 'details_product_event.dart';
part 'details_product_state.dart';

class DetailsProductBloc extends Bloc<DetailsProductEvent, DetailsProductStates> {
  DetailsProductBloc({@required DioHelper dioHelper}) : super(DetailsProductInitialState());
DioHelper dioHelper;
DetailsProductModel detailsProductModel;

LikesModel likesModel;

void detailsProductFun({@required String name}){
  
  DioHelper.getData(url: DETAILS_PRODUCT+name).then((value) {
    print(value.data);
    detailsProductModel=DetailsProductModel.fromJson(value.data);
var a=detailsProductModel.views;
var re=detailsProductModel.reacts;
    emit(DetailsProductSuccessState(a,re));
  }).catchError((error){
    emit(DetailsProductErrorState(error));});
}



void likesFun({@required var idProduct}){
  DioHelper.postDataLikes(url:"manage_likes/$idProduct").then((value){
    likesModel=LikesModel.fromJson(value.data);
    emit(DetailsProductsLikesSuccessState(likesModel));
  });
}

  }

