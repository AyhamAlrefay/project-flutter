part of 'edit_product_bloc.dart';

@immutable
abstract class EditProductStates {}

class EditProductInitialState extends EditProductStates {}
class EditProductLoadingState extends EditProductStates{}
class EditProductSuccessState extends EditProductStates{
  final EditProductModel editProductModel;

  EditProductSuccessState(this.editProductModel);
}
class EditProductErrorState extends EditProductStates{
  final EditProductModel editProductModel;

  EditProductErrorState(this.editProductModel);



}
