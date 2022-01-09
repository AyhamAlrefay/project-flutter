part of 'my_products_bloc.dart';

@immutable
abstract class MyProductsStates {}

class MyProductsInitialState extends MyProductsStates {}
class MyProductsLoadingState extends MyProductsStates {}
class MyProductsSuccessState extends MyProductsStates {
  final MyProductModel myProductModel;
final List list;
  MyProductsSuccessState(this.myProductModel, this.list);
}
class MyProductsErrorState extends MyProductsStates {
  final String error;

  MyProductsErrorState(this.error);
}