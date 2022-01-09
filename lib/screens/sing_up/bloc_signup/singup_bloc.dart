import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:project/network_utils/dio_helper.dart';
import 'package:project/network_utils/end_points.dart';

import 'package:project/screens/sing_up/sing_up_model.dart';
import 'package:project/shared/sharedpreferences.dart';

part 'singup_event.dart';

part 'singup_state.dart';


class SingUpBloc extends Bloc<SingUpEvent, SingUpStates> {
  SingUpModel singUpModel;
  DioHelper dioHelper;
  static String errorState;

  SingUpBloc({@required this.dioHelper}) : super(SingUpInitialState());
  //static LoginBloc get(context)=>BlocProvider.of(context);

  void userSingUp({
    @required var name,
    @required var email,
    @required var password,
    @required var passwordConf,
    @required var phoneNumber
  }){
    emit(SignUpLoadingState());
    DioHelper.postData( data:{
      "name": name,
      "email": email,
      "password": password,
      "password_confirmation": passwordConf,
      "phone_num": phoneNumber,
    }, url:REGISTER).then((value){

      singUpModel=SingUpModel.fromJson(value.data);
      emit(SignUpSuccessState(singUpModel));
    }).catchError((error){if(error.toString().contains('422') ) {
      errorState='The email has already been taken.';
      emit(SignUpErrorState(errorState));}});
  }


  bool isPassword = true;
  bool isPassConf = true;
  IconData suffixPass = Icons.visibility;
  IconData suffixPassConf = Icons.visibility;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffixPass = isPassword ? Icons.visibility : Icons.visibility_off;

    emit(ChangeSingUpPasswordVisibilityState());
  }

  void changePassConfVisibility() {
    isPassConf = !isPassConf;
    suffixPassConf = isPassConf ? Icons.visibility : Icons.visibility_off;

    emit(ChangeSingUpPasswordVisibilityState());
  }
}




