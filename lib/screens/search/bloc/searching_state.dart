part of 'searching_bloc.dart';

@immutable
abstract class SearchingStates {}

class SearchingInitialState extends SearchingStates {}
class SearchingLoadingState extends SearchingStates{}
class SearchingSuccessState extends SearchingStates{

final List<SearchModel> list;
  SearchingSuccessState( this.list);
}

class SearchingErrorState extends SearchingStates{

   var error;
  SearchingErrorState( this.error);
}


