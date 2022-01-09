part of 'singup_bloc.dart';

@immutable
abstract class SingUpStates {}

class SingUpInitialState extends SingUpStates {}

class SignUpLoadingState extends SingUpStates{}
class SignUpSuccessState extends SingUpStates{
  final SingUpModel singUpModel;
  SignUpSuccessState(this.singUpModel);
}
class SignUpErrorState extends SingUpStates
{
  final String error;

  SignUpErrorState(this.error);

 // SingUpModel singUpModel;

}

class ChangeSingUpPasswordVisibilityState extends SingUpStates {}

