import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:project/network_utils/dio_helper.dart';
import 'package:project/network_utils/end_points.dart';
import 'package:project/screens/my_products/my_product_model.dart';

part 'my_products_event.dart';
part 'my_products_state.dart';

class MyProductsBloc extends Bloc<MyProductsEvent, MyProductsStates> {
  DioHelper dioHelper;
  MyProductModel myProductModel;
  MyProductsBloc({@required DioHelper dioHelper}):super(MyProductsInitialState());
List <MyProductModel> listMyProducts=[];
 
  void myProductFun(){
emit(MyProductsLoadingState());
DioHelper.getData(url: MY_PRODUCT).then((value) {
  print("value==${value.data}");

  for(int i=0;i<value.data.length;i++)
    {
listMyProducts.add(MyProductModel.fromJson(value.data[i]));
    }
  emit(MyProductsSuccessState(myProductModel,listMyProducts));
}).catchError((error){emit(MyProductsErrorState(error));});

  }

void deleteProductFun({@required var idProduct}){
    DioHelper.getData(url:DELETE_PRODUCT+idProduct);
}

}
