import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:project/network_utils/dio_helper.dart';
import 'package:project/network_utils/end_points.dart';
import 'package:project/screens/add_category/add_category_model.dart';

part 'add_category_event.dart';
part 'add_category_state.dart';

class AddCategoryBloc extends Bloc<AddCategoryEvent, AddCategoryStates> {

  AddCategoryModel addCategoryModel;
  DioHelper dioHelper;
  static String errorState;
  AddCategoryBloc({@required this.dioHelper}) : super(AddCategoryInitialState());

  void userAddCategory({
    @required var name,
  }){
    emit(AddCategoryLoadingState());
    print("aaaaa=$name");
    DioHelper.postData( data:{
       "name":name,
    }, url:ADD_CATEGORY).then((value){


      print(value.data);
      addCategoryModel=AddCategoryModel.fromJson(value.data);
      emit(AddCategorySuccessState(addCategoryModel));

    }).catchError((error){if(error.toString().contains('422') ) {
    errorState='The name has already been taken.';
    emit(AddCategoryErrorState(errorState));}});}
  }



