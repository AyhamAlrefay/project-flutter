part of 'edit_category_bloc.dart';

@immutable
abstract class EditCategoryStates {}

class EditCategoryBlocInitialState extends EditCategoryStates {}
class EditCategoryLoadingState extends EditCategoryStates {}
class EditCategorySuccessState extends EditCategoryStates {
  final List list;

  EditCategorySuccessState(this.list);
}
class EditCategoryErrorState extends EditCategoryStates
{
  final String error;
  EditCategoryErrorState(this.error);
}