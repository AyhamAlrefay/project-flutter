part of 'login_bloc.dart';

@immutable
abstract class LoginStates {}

class LoginInitialState extends LoginStates {}
class LoginLoadingState extends LoginStates {}
class LoginSuccessState extends LoginStates
{
final LoginModel loginModel;

  LoginSuccessState(this.loginModel);

}
class LoginErrorState extends LoginStates
{
final String error;
  LoginErrorState(this.error);
}

class ChangePasswordVisibilityState extends LoginStates {}