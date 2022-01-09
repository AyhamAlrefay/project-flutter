part of 'category_bloc.dart';

@immutable
abstract class CategoryStates {}
class ChangeEditCategoryState extends CategoryStates{}
class CategoryIdFunState extends CategoryStates{}
class CategoryInitialState extends CategoryStates {}
class CategoryLoadingState extends CategoryStates {}
class CategorySuccessState extends CategoryStates {
  final CategoryModel categoryModel;
  final List listName;
  final List listId;
  CategorySuccessState(this.categoryModel,this.listName, this.listId);

}
class CategoryErrorState extends CategoryStates {
  final String error;
  CategoryErrorState(this.error);
}



class OneCategoryLoadingState extends CategoryStates {}
class OneCategorySuccessStates extends CategoryStates {
  final String nameCategory;

  OneCategorySuccessStates(this.nameCategory);
}
class OneCategoryErrorStates extends CategoryStates {
  final String error;

  OneCategoryErrorStates(this.error);

}

class DeleteCategorySuccessStates extends CategoryStates {
  final list;

  DeleteCategorySuccessStates(this.list);
}

