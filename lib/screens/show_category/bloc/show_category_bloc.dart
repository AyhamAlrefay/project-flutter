

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:project/network_utils/dio_helper.dart';
import 'package:project/network_utils/end_points.dart';
import 'package:project/screens/show_category/show_category_model.dart';

part 'show_category_event.dart';
part 'show_category_state.dart';

class ShowCategoryBloc extends Bloc<ShowCategoryEvent, ShowCategoryStates> {
  DioHelper dioHelper;
  ShowCategoryModel showCategoryModel;
  
  ShowCategoryBloc({@required DioHelper dioHelper}) : super(ShowCategoryInitialState());
  
  List<ShowCategoryModel> listShowCategory=[];
  void showCategoryFun({@required var idCategory}){
    emit(ShowCategoryLoadingState());
    DioHelper.getData(url: SHOW_CATEGORY+idCategory).then((value) {

      for(int i=0;i<value.data.length;i++)
        listShowCategory.add(ShowCategoryModel.fromJson(value.data[i]));

      emit(ShowCategorySuccessState(showCategoryModel,listShowCategory));
    }).catchError((error){emit(ShowCategoryErrorState(error));});
    
    
  }
  
  
  
}
