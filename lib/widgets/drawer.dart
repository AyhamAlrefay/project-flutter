import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/network_utils/dio_helper.dart';
import 'package:project/screens/login/login.dart';
import 'package:project/screens/profile/bloc/profile_bloc.dart';
import 'package:project/screens/profile/profile_model.dart';
import 'package:project/screens/profile/profile_screen.dart';
import 'package:project/screens/sing_up/sing_up.dart';
import 'package:project/shared/sharedpreferences.dart';


class DrawerProduct extends StatefulWidget {
  const DrawerProduct({Key key}) : super(key: key);

  @override
  _DrawerProductState createState() => _DrawerProductState();
}

class _DrawerProductState extends State<DrawerProduct> {
  ProfileModel profileModel;
  ProfileBloc profileBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  profileBloc=ProfileBloc(dioHelper: DioHelper());

  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(create: (BuildContext context)=>profileBloc,
    child: BlocConsumer<ProfileBloc,ProfileStates>(
      listener: (context,state){
        if(state is ProfileSuccessState)
          {
            profileModel=state.profileModel;
            CacheHelper.saveData(key: 'nameProfile', value: profileModel.name);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage(profileModel: profileModel,)),
            );
          }
      },
builder: (context,state){


    return   Drawer(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.2),
                    Theme.of(context).accentColor.withOpacity(0.5),
                  ])),
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  //color: Theme.of(context).primaryColor,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).accentColor,
                    ],
                  ),
                ),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "CartShop",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              ListTile(
                leading: Icon(Icons.login_rounded,
                    size: 24,
                    color: Theme.of(context).accentColor),
                title: Text(
                  'Login Page',
                  style: TextStyle(
                      fontSize: 17,
                      color: Theme.of(context).accentColor),
                ),
                onTap: () {
                  CacheHelper.removeData(key: "token").then((value) {
                    if(value)
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginUiScreen()),
                      );
                  });

                },
              ),
              Divider(
                  color: Theme.of(context).primaryColor,
                  height: 1
              ),
              ListTile(
                leading: Icon(Icons.person_add_alt_1,
                    size: 24,
                    color: Theme.of(context).accentColor),
                title: Text(
                  'Registration Page',
                  style: TextStyle(
                      fontSize: 17,
                      color: Theme.of(context).accentColor),
                ),
                onTap: () {
                  CacheHelper.removeData(key: "token").then((value) {if(value)
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SingUp()),
                    );
                  });

                },
              ),
              Divider(
                  color: Theme.of(context).primaryColor,
                  height: 1
              ),

              ListTile(
                leading: Icon(
                  Icons.person,
                  size: 24,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  'Profile',
                  style: TextStyle(
                      fontSize: 17,
                      color: Theme.of(context).accentColor),
                ),
                onTap: () {
                  profileBloc.profileFun();

                },
              ),
              Divider(
                  color: Theme.of(context).primaryColor,
                  height: 1
              ),
              ListTile(
                leading: Icon(
                  Icons.login_rounded,
                  size: 24,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(
                      fontSize: 17,
                      color: Theme.of(context).accentColor),
                ),
                onTap: () {
                  CacheHelper.removeData(key: "token").then((value) {
                    if(value)
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginUiScreen()),
                      );});
                },
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
