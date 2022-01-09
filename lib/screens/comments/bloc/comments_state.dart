part of 'comments_bloc.dart';

@immutable
abstract class CommentsStates {}

class CommentsInitialState extends CommentsStates {}
class CommentsSuccessStaState extends CommentsStates {}
class CommentsErrorStaState extends CommentsStates {
  final String error;

  CommentsErrorStaState(this.error);

}

