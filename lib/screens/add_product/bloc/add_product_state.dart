part of 'add_product_bloc.dart';



@immutable
abstract class AddProductStates {}

class AddProductInitialState extends AddProductStates {}

class AddProductLoadingState extends AddProductStates {}
class AddProductSuccessState extends AddProductStates
{
  final AddProductModel addProductModel;

  AddProductSuccessState(this.addProductModel);

}
class AddProductErrorState extends AddProductStates
{
  final String error;
  AddProductErrorState(this.error);
}
