import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:project/network_utils/dio_helper.dart';
import 'package:project/network_utils/end_points.dart';
import 'package:project/screens/add_category/bloc/add_category_bloc.dart';
import 'package:project/screens/category/dio_helper_category.dart';

part 'edit_category_event.dart';
part 'edit_category_state.dart';

class EditCategoryBloc extends Bloc<EditCategoryEvent, EditCategoryStates> {
List listId=[];
  DioHelper dioHelper;
  static String errorState;
  EditCategoryBloc({@required this.dioHelper}) : super(EditCategoryBlocInitialState());

  void editCategory({@required var name,@required var idCategory}){
    emit(EditCategoryLoadingState());
    DioHelperCategory.postData(url:EDIT_CATEGORY+idCategory , data:{"name":name} ).then((value) {
      emit(EditCategorySuccessState(listId));
    });
  }
}

