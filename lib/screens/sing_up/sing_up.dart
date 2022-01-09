
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/common/components.dart';
import 'package:project/network_utils/dio_helper.dart';
import 'package:project/screens/category/category.dart';
import 'package:project/screens/sing_up/bloc_signup/singup_bloc.dart';
import 'package:project/screens/sing_up/sing_up_model.dart';
import 'package:project/shared/sharedpreferences.dart';
import 'package:project/widgets/header_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project/common/theme_helper.dart';
class SingUp extends StatefulWidget {
  const SingUp({Key key}) : super(key: key);

  @override
  _SingUpState createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {

  final _formKey = GlobalKey<FormState>();

  var userNameController = TextEditingController();
  var emailAddressController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  bool value = true;
  bool isTrue = true;
  SingUpBloc singUpBloc;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    singUpBloc = SingUpBloc(dioHelper: DioHelper());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SingUpBloc>(
        create: (BuildContext context) => singUpBloc,
        child: BlocConsumer<SingUpBloc, SingUpStates>(listener: (context, state) {
          if (state is SignUpSuccessState) {

            CacheHelper.saveData(key: "token", value: state.singUpModel.token)
                .then((value) => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Category())));
            showToast(
                text: state.singUpModel.msg, state: ToastStates.SUCCESS);

          } if(state is SignUpErrorState){
            // print(state.singUpModel.message);
            showToast(text: SingUpBloc.errorState, state: ToastStates.ERROR);
          }
        }, builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  //Decoration in top screen
                  Container(
                    height: 150,
                    child: HeaderWidget(
                        height: 150, icon: Icons.person, visibility: false),
                  ),
                  //Icons on Decoration with FormField
                  Container(
                    margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        //Icons on Decoration
                        Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border:
                                Border.all(width: 5, color: Colors.white),
                                color: Colors.white,
                              ),
                              child: Icon(
                                Icons.person,
                                color: Colors.grey.shade300,
                                size: 80.0,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(80, 80, 0, 0),
                              child: Icon(
                                Icons.add_circle,
                                color: Colors.grey.shade700,
                                size: 25,
                              ),
                            ),
                          ],
                        ),
                        //FormField
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              //////////First of Field Register///////////////
                              SizedBox(height: 30),
                              //User Name
                              TextFormField(
                                controller: userNameController,
                                keyboardType: TextInputType.name,
                                decoration: ThemeHelper().textInputDecoration(
                                    lableText: 'User Name',
                                    hintText: 'Enter your name',
                                    icon:
                                    Icon(Icons.drive_file_rename_outline)),
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "Enter your name";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 30),
                              //E-mail address
                              TextFormField(
                                controller: emailAddressController,
                                decoration: ThemeHelper().textInputDecoration(
                                    lableText: "E-mail address",
                                    hintText: "Enter your email",
                                    icon: Icon(Icons.email)),
                                keyboardType: TextInputType.emailAddress,
                                validator: (val) {
                                  if (val.isEmpty || !val.contains("@")) {
                                    return "Enter a valid email address";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),
                              //Phone Number
                              TextFormField(
                                controller: phoneNumberController,
                                decoration: ThemeHelper().textInputDecoration(
                                    lableText: "Phone Number",
                                    hintText: "Enter your mobile number",
                                    icon: Icon(Icons.phone)),
                                keyboardType: TextInputType.phone,
                                validator: (val) {
                                  if (val.isEmpty ||
                                      !RegExp(r"^(\d+)*$").hasMatch(val)) {
                                    return "Enter a valid phone number";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),
                              //Password

                              TextFormField(
                                  obscureText: singUpBloc.isPassword,
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return "Please Enter New Password";
                                    } else if (val.length < 8) {
                                      return "Password must be at least 8 characters long";
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                    labelText: "password",
                                    hintText: "Enter your password",
                                    fillColor: Colors.white,
                                    filled: true,
                                    prefixIcon: Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                        icon: Icon(singUpBloc.suffixPass),
                                        onPressed: () {
                                          singUpBloc.changePasswordVisibility();
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

                              SizedBox(height: 20),
                              //ConfirmPassword

                              TextFormField(
                                  controller: confirmPasswordController,
                                  obscureText: singUpBloc.isPassConf,
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return "Please Re-Enter New Password";
                                    } else if (val.length < 8) {
                                      return "Password must be at least 8 characters long";
                                    } else if (val != passwordController.text) {
                                      return "Password must be same as above";
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Confirm password",
                                    hintText: "Enter the password for confirm",
                                    fillColor: Colors.white,
                                    filled: true,
                                    prefixIcon: Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                        icon: Icon(singUpBloc.suffixPassConf),
                                        onPressed: () {
                                          singUpBloc.changePassConfVisibility();
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
                              SizedBox(height: 35),
                              //////////End of Fields///////////////

                              // Button Register
                              BlocBuilder<SingUpBloc, SingUpStates>(
                                  builder: (context, state) {
                                    if (state is SignUpLoadingState) {
                                      return const CircularProgressIndicator();
                                    }
                                    return
                                      Container(
                                        decoration:
                                        ThemeHelper().buttonBoxDecoration(context),
                                        child: ElevatedButton(
                                          style: ThemeHelper().buttonStyle(),
                                          child: Padding(
                                            padding:
                                            EdgeInsets.fromLTRB(40, 10, 40, 10),
                                            child: Text(
                                              "REGISTER",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            if (_formKey.currentState.validate()) {
                                              singUpBloc.userSingUp(
                                                  name: userNameController.text,
                                                  email: emailAddressController.text,
                                                  password: passwordController.text,
                                                  passwordConf: confirmPasswordController.text,
                                                  phoneNumber: phoneNumberController.text
                                              );

                                            }
                                          },
                                        ),
                                      );
                                  }),

                              SizedBox(height: 30.0),
                              Text("Or create account using social media",
                                  style: TextStyle(color: Colors.grey)),
                              SizedBox(height: 25.0),
                              //Icon under the button
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //google plus
                                  GestureDetector(
                                    child: FaIcon(
                                      FontAwesomeIcons.googlePlus,
                                      size: 35,
                                      color: Color(0xffEC2D2F),
                                    ),
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return ThemeHelper().alartDialog(
                                              "Google Plus",
                                              "You can\'t create account by google plus now.",
                                              context);
                                        },
                                      );
                                    },
                                  ),
                                  SizedBox(width: 30.0),
                                  //twitter
                                  GestureDetector(
                                    child: Container(
                                      padding: EdgeInsets.all(0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(100),
                                        border: Border.all(
                                            width: 5, color: Color(0xff40ABF0)),
                                        color: Color(0xff40ABF0),
                                      ),
                                      child: FaIcon(
                                        FontAwesomeIcons.twitter,
                                        size: 23,
                                        color: Color(0xffFFFFFF),
                                      ),
                                    ),
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return ThemeHelper().alartDialog(
                                              "Twitter",
                                              "You can\'t create account by twitter now.",
                                              context);
                                        },
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    width: 30.0,
                                  ),
                                  //facebook
                                  GestureDetector(
                                    child: FaIcon(
                                      FontAwesomeIcons.facebook,
                                      size: 35,
                                      color: Color(0xff3E529C),
                                    ),
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return ThemeHelper().alartDialog(
                                              "Facebook",
                                              "You can\'t create account by facebook now.",
                                              context);
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }));
  }

}



/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/common/components.dart';
import 'package:project/network_utils/dio_helper.dart';
import 'package:project/screens/category/category.dart';
import 'package:project/screens/sing_up/bloc_signup/singup_bloc.dart';
import 'package:project/screens/sing_up/sing_up_model.dart';
import 'package:project/shared/sharedpreferences.dart';
import 'package:project/widgets/header_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project/common/theme_helper.dart';


class SingUp extends StatefulWidget {
  @override
  _SingUpState createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  final _formKey = GlobalKey<FormState>();

  var userNameController = TextEditingController();
  var emailAddressController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  bool value = true;
  bool isTrue = true;
  SingUpBloc singUpBloc;
  //SingUpModel singUpModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    singUpBloc = SingUpBloc(dioHelper: DioHelper());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SingUpBloc>(
      create: (BuildContext context) => singUpBloc,
      child: BlocConsumer<SingUpBloc, SingUpStates>(
        listener: (context, state) {
          if (state is SignUpSuccessState) {

              print( "msgggggggggggggggggggggggggggg= ${state.singUpModel.msg}");
            //  print(state.singUpModel.token);
              CacheHelper.saveData(key: "token", value: state.singUpModel.token)
                  .then((value) => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Category())));
              showToast(
                  text: state.singUpModel.msg, state: ToastStates.SUCCESS);

          }else if(state is SignUpErrorState){
           // print(state.singUpModel.message);
            showToast(text: SingUpBloc.errorState, state: ToastStates.ERROR);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  //Decoration in top screen
                  Container(
                    height: 150,
                    child: HeaderWidget(
                        height: 150, icon: Icons.person, visibility: false),
                  ),
                  //Icons on Decoration with FormField
                  Container(
                    margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        //Icons on Decoration
                        Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border:
                                    Border.all(width: 5, color: Colors.white),
                                color: Colors.white,
                              ),
                              child: Icon(
                                Icons.person,
                                color: Colors.grey.shade300,
                                size: 80.0,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(80, 80, 0, 0),
                              child: Icon(
                                Icons.add_circle,
                                color: Colors.grey.shade700,
                                size: 25,
                              ),
                            ),
                          ],
                        ),
                        //FormField
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              //////////First of Field Register///////////////
                              SizedBox(height: 30),
                              //User Name
                              TextFormField(
                                controller: userNameController,
                                keyboardType: TextInputType.name,
                                decoration: ThemeHelper().textInputDecoration(
                                    lableText: 'User Name',
                                    hintText: 'Enter your name',
                                    icon:
                                        Icon(Icons.drive_file_rename_outline)),
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "Enter your name";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 30),
                              //E-mail address
                              TextFormField(
                                controller: emailAddressController,
                                decoration: ThemeHelper().textInputDecoration(
                                    lableText: "E-mail address",
                                    hintText: "Enter your email",
                                    icon: Icon(Icons.email)),
                                keyboardType: TextInputType.emailAddress,
                                validator: (val) {
                                  if (val.isEmpty || !val.contains("@")) {
                                    return "Enter a valid email address";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),
                              //Phone Number
                              TextFormField(
                                controller: phoneNumberController,
                                decoration: ThemeHelper().textInputDecoration(
                                    lableText: "Phone Number",
                                    hintText: "Enter your mobile number",
                                    icon: Icon(Icons.phone)),
                                keyboardType: TextInputType.phone,
                                validator: (val) {
                                  if (val.isEmpty ||
                                      !RegExp(r"^(\d+)*$").hasMatch(val)) {
                                    return "Enter a valid phone number";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),
                              //Password

                              TextFormField(
                                  obscureText: singUpBloc.isPassword,
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return "Please Enter New Password";
                                    } else if (val.length < 8) {
                                      return "Password must be at least 8 characters long";
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                    labelText: "password",
                                    hintText: "Enter your password",
                                    fillColor: Colors.white,
                                    filled: true,
                                    prefixIcon: Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                        icon: Icon(singUpBloc.suffixPass),
                                        onPressed: () {
                                          singUpBloc.changePasswordVisibility();
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

                              SizedBox(height: 20),
                              //ConfirmPassword

                              TextFormField(
                                  controller: confirmPasswordController,
                                  obscureText: singUpBloc.isPassConf,
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return "Please Re-Enter New Password";
                                    } else if (val.length < 8) {
                                      return "Password must be at least 8 characters long";
                                    } else if (val != passwordController.text) {
                                      return "Password must be same as above";
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Confirm password",
                                    hintText: "Enter the password for confirm",
                                    fillColor: Colors.white,
                                    filled: true,
                                    prefixIcon: Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                        icon: Icon(singUpBloc.suffixPassConf),
                                        onPressed: () {
                                          singUpBloc.changePassConfVisibility();
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
                              SizedBox(height: 35),
                              //////////End of Fields///////////////

                              // Button Register
    BlocBuilder<SingUpBloc, SingUpStates>(
    builder: (context, state) {
      if (state is SignUpLoadingState) {
        return const CircularProgressIndicator();
      }
      return
        Container(
          decoration:
          ThemeHelper().buttonBoxDecoration(context),
          child: ElevatedButton(
            style: ThemeHelper().buttonStyle(),
            child: Padding(
              padding:
              EdgeInsets.fromLTRB(40, 10, 40, 10),
              child: Text(
                "REGISTER",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                singUpBloc.userSingUp(
                    name: userNameController.text,
                    email: emailAddressController.text,
                    password: passwordController.text,
                    passwordConf: confirmPasswordController.text,
                    phoneNumber: phoneNumberController.text
                     );

              }
            },
          ),
        );
    }),

                              SizedBox(height: 30.0),
                              Text("Or create account using social media",
                                  style: TextStyle(color: Colors.grey)),
                              SizedBox(height: 25.0),
                              //Icon under the button
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //google plus
                                  GestureDetector(
                                    child: FaIcon(
                                      FontAwesomeIcons.googlePlus,
                                      size: 35,
                                      color: Color(0xffEC2D2F),
                                    ),
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return ThemeHelper().alartDialog(
                                              "Google Plus",
                                              "You can\'t create account by google plus now.",
                                              context);
                                        },
                                      );
                                    },
                                  ),
                                  SizedBox(width: 30.0),
                                  //twitter
                                  GestureDetector(
                                    child: Container(
                                      padding: EdgeInsets.all(0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(
                                            width: 5, color: Color(0xff40ABF0)),
                                        color: Color(0xff40ABF0),
                                      ),
                                      child: FaIcon(
                                        FontAwesomeIcons.twitter,
                                        size: 23,
                                        color: Color(0xffFFFFFF),
                                      ),
                                    ),
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return ThemeHelper().alartDialog(
                                              "Twitter",
                                              "You can\'t create account by twitter now.",
                                              context);
                                        },
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    width: 30.0,
                                  ),
                                  //facebook
                                  GestureDetector(
                                    child: FaIcon(
                                      FontAwesomeIcons.facebook,
                                      size: 35,
                                      color: Color(0xff3E529C),
                                    ),
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return ThemeHelper().alartDialog(
                                              "Facebook",
                                              "You can\'t create account by facebook now.",
                                              context);
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
*/