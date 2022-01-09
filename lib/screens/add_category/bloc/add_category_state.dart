part of 'add_category_bloc.dart';

@immutable
abstract class AddCategoryStates {}

class AddCategoryInitialState extends AddCategoryStates {}
class AddCategoryLoadingState extends AddCategoryStates {}
class AddCategorySuccessState extends AddCategoryStates
{
  final AddCategoryModel addCategoryModel;

  AddCategorySuccessState(this.addCategoryModel);


}
class AddCategoryErrorState extends AddCategoryStates
{
  final String error;
  AddCategoryErrorState(this.error);
}
