

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:project/network_utils/dio_helper.dart';
import 'package:project/network_utils/end_points.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsStates> {
  CommentsBloc({@required DioHelper dioHelper}) : super(CommentsInitialState()) ;
    void commentFun({@required var idProduct,@required var body}){
      DioHelper.postData(url:'create_comment/$idProduct', data: {
        'body':body
      }).then((value) {

        emit(CommentsSuccessStaState());
      }).catchError((error){
        emit(CommentsErrorStaState(error));});


    }
}
