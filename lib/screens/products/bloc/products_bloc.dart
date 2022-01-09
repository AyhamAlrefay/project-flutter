import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:project/network_utils/end_points.dart';
import 'package:project/screens/category/dio_helper_category.dart';
import 'package:project/screens/products/name_model.dart';
import 'package:project/screens/products/product_model.dart';


part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsStates> {
  DioHelperCategory dioHelperCategory;
  ProductsModel productsModel;
  NameModel nameModel;
  ProductsBloc({@required this.dioHelperCategory}) : super(ProductsInitialState());
List<ProductsModel> listProducts=[];
  List<ProductsModel> listProductsSort=[];
  dynamic AllProducts(){
    emit(ProductsLoadingState());
    listProducts=[];
    DioHelperCategory.getData(url: ALL_PRODUCTS)
        .then((value) {
          for(int i=0;i<value.data.length;i++)
      listProducts.add(ProductsModel.fromJson(value.data[i]));
      emit(ProductsSuccessState(listProducts));}
    ).catchError((error){emit(ProductsErrorState(error));});
  }

dynamic sortingProducts(){
    listProductsSort=[];
    DioHelperCategory.getData(url:SORTING).then((value) {
      for(int i=0;i<value.data.length;i++)
        listProductsSort.add(ProductsModel.fromJson(value.data[i]));
      emit(ProductsSortSuccessState(listProductsSort));}
    ).catchError((error){emit(ProductsSortErrorState(error));});
}



  List<NameModel> listName=[];
  dynamic listFun(){
    listName=[];
    emit(NameLoadingState());
    DioHelperCategory.getData(url: "list_names")
        .then((value) {
      for (int i=0;i<value.data.length;i++)
        listName.add(NameModel.fromJson(value.data[i]));
      emit(NameSuccessState(listName));
    }).catchError((error){});
  }

}
