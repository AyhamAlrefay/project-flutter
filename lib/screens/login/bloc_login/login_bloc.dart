import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:project/network_utils/dio_helper.dart';
import 'package:project/network_utils/end_points.dart';
import 'package:project/screens/login/login_model.dart';
import 'package:project/screens/profile/profile_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginStates> {
 LoginModel loginModel;
  DioHelper dioHelper;

  LoginBloc({@required this.dioHelper}) : super(LoginInitialState());

  void userLogin({
   @required var email,@required var password
  }){
    emit(LoginLoadingState());
    DioHelper.postData( data:{
      "email":email,
      "password":password,
    }, url:LOGIN  ).then((value){
      loginModel=LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel));

    }).catchError((error){emit(LoginErrorState(error.toString()));});
  }




bool isPassword=true;
  IconData suffix=Icons.visibility;

void changePasswordVisibility(){
  isPassword=!isPassword;
  suffix=isPassword ? Icons.visibility: Icons.visibility_off;

  emit(ChangePasswordVisibilityState());
}

}

