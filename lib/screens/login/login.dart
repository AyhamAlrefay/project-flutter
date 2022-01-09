import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/common/components.dart';
import 'package:project/common/theme_helper.dart';
import 'package:project/network_utils/dio_helper.dart';
import 'package:project/screens/category/category.dart';
import 'package:project/screens/login/bloc_login/login_bloc.dart';
import 'package:project/screens/sing_up/sing_up.dart';
import 'package:project/shared/sharedpreferences.dart';
import 'package:project/widgets/header_widget.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LoginUiScreen extends StatefulWidget {
  @override
  _LoginUiScreenState createState() => _LoginUiScreenState();
}

class _LoginUiScreenState extends State<LoginUiScreen> {
  final _formKey = GlobalKey<FormState>();
  var loginEmailController = TextEditingController();
  var loginPasswordController = TextEditingController();
  bool value = true;
  LoginBloc loginBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginBloc = LoginBloc(dioHelper: DioHelper());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
        create: (BuildContext context) => loginBloc,
        child: BlocConsumer<LoginBloc, LoginStates>(listener: (context, state) {
          if (state is LoginSuccessState) {
            CacheHelper.saveData(key: "token", value: state.loginModel.token)
                .then((value) => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Category())));
            showToast(text: state.loginModel.msg, state: ToastStates.SUCCESS);}
         if(state is LoginErrorState) {
              showToast(text: "invalid email or password .", state: ToastStates.ERROR);
            }
         // }
        }, builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  //HeaderWidget
                  Container(
                      height: 230,
                      child: HeaderWidget(
                          height: 230,
                          icon: Icons.login_rounded,
                          visibility: true)),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Column(
                      children: [
                        Text('Hello',
                            style: TextStyle(
                                fontSize: 60, fontWeight: FontWeight.bold)),
                        Text('Login into your account',
                            style: TextStyle(color: Colors.grey)),
                        SizedBox(height: 30),
                        //Forms email and password
                        Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                //Form for email
                                Container(
                                  child: TextFormField(
                                    validator: (val) {
                                      if (val.isEmpty || !val.contains("@")) {
                                        return "Enter a valid email address";
                                      }
                                      return null;
                                    },
                                    controller: loginEmailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: ThemeHelper()
                                        .textInputDecoration(
                                            lableText: 'Email address ',
                                            hintText: 'Enter your email',
                                            icon: Icon(Icons.email)),
                                  ),
                                ),
                                SizedBox(height: 30.0),
                                //Form for password

                                TextFormField(
                                    obscureText: loginBloc.isPassword,
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Please Enter New Password";
                                      } else if (val.length < 8) {
                                        return "Password must be at least 8 characters long";
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: loginPasswordController,
                                    decoration: InputDecoration(
                                      labelText: "password",
                                      hintText: "Enter your password",
                                      fillColor: Colors.white,
                                      filled: true,
                                      prefixIcon: Icon(Icons.lock),
                                      suffixIcon: IconButton(
                                          icon: Icon(loginBloc.suffix),
                                          onPressed: () {
                                            loginBloc
                                                .changePasswordVisibility();
                                          }),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(80.0),
                                          borderSide:
                                              BorderSide(color: Colors.grey)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(80.0),
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade400)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(80.0),
                                          borderSide: BorderSide(
                                              color: Colors.red, width: 2.0)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                          borderSide: BorderSide(
                                              color: Colors.red, width: 2.0)),
                                    )),

                                SizedBox(height: 15.0),
                                //button login
                                // ConditionalBuilder(condition: state is! LoginLoadingState,
                                //     builder:(context)=>
                                BlocBuilder<LoginBloc, LoginStates>(
                                    builder: (context, state) {
                                  if (state is LoginLoadingState) {
                                    return const CircularProgressIndicator();
                                  }
                                  return Container(
                                    decoration: ThemeHelper()
                                        .buttonBoxDecoration(context),
                                    child: ElevatedButton(
                                        style: ThemeHelper().buttonStyle(),
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              40, 10, 40, 10),
                                          child: Text(
                                            'LOGIN',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                        onPressed: () {
                                          if (_formKey.currentState
                                              .validate()) {

                                            loginBloc.userLogin(
                                                email:
                                                    loginEmailController.text,
                                                password:
                                                    loginPasswordController
                                                        .text);
                                          }
                                        }),
                                  );
                                }),

                                //if you don't have account
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text.rich(TextSpan(children: [
                                        TextSpan(
                                            text: "Don\'t have an account? "),
                                      ])),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => SingUp()),
                                          );
                                        },
                                        child: Text(
                                          "Create",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .accentColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }));
  }
}
