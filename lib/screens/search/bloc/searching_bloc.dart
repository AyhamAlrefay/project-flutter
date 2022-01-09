import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:project/network_utils/end_points.dart';
import 'package:project/screens/search/diohelper_search.dart';
import 'package:project/screens/search/search_model.dart';

part 'searching_event.dart';
part 'searching_state.dart';

class SearchingBloc extends Bloc<SearchingEvent, SearchingStates> {
 DioHelperSearch dioHelperSearch;
SearchModel searchModel;
SearchingBloc({@required this.dioHelperSearch}):super (SearchingInitialState());
List <SearchModel>listSearch =[];
dynamic searchingFun({@required var name}){
 DioHelperSearch.getData(url: SEARCHING_NAME+name).then((value){
listSearch=[];
  for(int i=0; i<value.data.length;i++)
   {
    listSearch.add(SearchModel.fromJson(value.data[i]));
   }
  emit(SearchingSuccessState(listSearch));
 }).catchError((error){emit(SearchingErrorState(error));});
}
}
