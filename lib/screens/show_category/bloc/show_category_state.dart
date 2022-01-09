part of 'show_category_bloc.dart';

@immutable
abstract class ShowCategoryStates {}

class ShowCategoryInitialState extends ShowCategoryStates {}

class ShowCategoryLoadingState extends ShowCategoryStates {}
class ShowCategorySuccessState extends ShowCategoryStates {
  final ShowCategoryModel showCategoryModel;
final List list;
  ShowCategorySuccessState(this.showCategoryModel,this.list);
}
class ShowCategoryErrorState extends ShowCategoryStates {
  final String error;

  ShowCategoryErrorState(this.error);

}


