part of 'products_bloc.dart';

@immutable
abstract class ProductsStates {}

class ProductsInitialState extends ProductsStates {}

class ProductsLoadingState extends ProductsStates{}
class ProductsSuccessState extends ProductsStates{
final List list;

  ProductsSuccessState( this.list);
}
class ProductsErrorState extends ProductsStates
{
  final String error;

  ProductsErrorState(this.error);


}

class ChangeSortState extends ProductsStates{}



class ProductsSortSuccessState extends ProductsStates{

  final List listSort;

  ProductsSortSuccessState( this.listSort);
}
class ProductsSortErrorState extends ProductsStates
{
  final String error;

  ProductsSortErrorState(this.error);

}




class NameLoadingState extends ProductsStates{}
class NameSuccessState extends ProductsStates{
  final List <dynamic>list;

  NameSuccessState(this.list);
}
class NameErrorState extends ProductsStates{
}