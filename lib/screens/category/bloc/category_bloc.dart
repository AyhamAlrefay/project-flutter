import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:project/network_utils/end_points.dart';
import 'package:project/screens/category/category_model.dart';
import 'package:project/screens/category/dio_helper_category.dart';
import 'package:project/screens/one_category/one_category_model.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryStates> {

 CategoryModel categoryModel;
 OneCategoryModel oneCategoryModel;
 DioHelperCategory  dioHelperCategory;
List<String> listName=[];
List listId=[];
List <dynamic> listOneCategory=[];


  CategoryBloc({@required this.dioHelperCategory}) : super(CategoryInitialState());


 dynamic AllCategory(){
   emit(CategoryLoadingState());
   DioHelperCategory.getData(url: ALL_CATEGORY).then((value) {
     categoryModel=CategoryModel.fromJson(value.data);
     for(int i=0;i< categoryModel.data.length;i++)
         {listName.add(categoryModel.data[i].name);
          listId.add(categoryModel.data[i].id);}

     emit(CategorySuccessState(categoryModel,listName,listId));
   }).catchError((error){emit(CategoryErrorState(error));});
 }
dynamic nameCategory="";

 dynamic oneCategory(idCategory){
   emit(OneCategoryLoadingState());
   DioHelperCategory.getDataOne(url:ONE_CATEGORY,idCategory:idCategory ).then((value) {

     oneCategoryModel=OneCategoryModel.fromJson(value.data);
nameCategory=oneCategoryModel.name;
print(nameCategory);
emit(OneCategorySuccessStates(nameCategory));
   }).catchError((error){emit(OneCategoryErrorStates(error));});
 }


 dynamic deletCategory(idCategory){
   DioHelperCategory.deleteCategory(url:DELETE_CATEGORY,idCategory: idCategory ).then((value) {
     emit(DeleteCategorySuccessStates(listId));
   });

 }


}
