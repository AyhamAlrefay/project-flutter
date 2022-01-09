part of 'details_product_bloc.dart';

@immutable
abstract class DetailsProductStates {}

class DetailsProductInitialState extends DetailsProductStates {}

class DetailsProductLoadingState extends DetailsProductStates {}
class DetailsProductSuccessState extends DetailsProductStates {
  final int a;
final int re;
  DetailsProductSuccessState(this.a,this.re);

}

class DetailsProductErrorState extends DetailsProductStates {
  final String error;

  DetailsProductErrorState(this.error);

}

class DetailsProductsLikesSuccessState extends DetailsProductStates{
  final LikesModel likesModel;

  DetailsProductsLikesSuccessState(this.likesModel);
}