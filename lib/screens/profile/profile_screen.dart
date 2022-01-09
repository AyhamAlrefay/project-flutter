import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/screens/profile/profile_model.dart';
import 'package:project/widgets/header_widget.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  final ProfileModel profileModel;

  const ProfilePage({Key key, this.profileModel}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  File image;

  Future getImage(ImageSource src) async {
    final pickerFile = await ImagePicker().getImage(source: src);
    setState(() {
      if (pickerFile != null) {
        image = File(pickerFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.drive_file_rename_outline), onPressed: () {})
        ],
        title: Text(
          "Profile ",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.2,
        //for hide line appBar
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Theme.of(context).primaryColor,
                Theme.of(context).accentColor,
              ])),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 100,
              child: HeaderWidget(
                height: 100,
                icon: Icons.person,
                visibility: false,
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 2, color: Colors.white),
                            color: Colors.white,
                          ),
                          child: image == null
                              ? Icon(
                                  Icons.person,
                                  color: Colors.grey.shade300,
                                  size: 150.0,
                                )
                              : CircleAvatar(
                                  backgroundImage: FileImage(image),
                                  radius: 80,
                                ),
                        ),
                        Positioned(
                          left: 120,
                          top: 120,
                          child: IconButton(
                            icon: Icon(Icons.add_a_photo),
                            color: Colors.grey.shade700,
                            iconSize: 30,
                            onPressed: () {
                              var ad = AlertDialog(
                                title: Text("chose photo from :"),
                                content: Container(
                                  height: 150,
                                  child: Column(
                                    children: [
                                      Divider(
                                        height: 10,
                                      ),
                                      Container(
                                        color: Theme.of(context).primaryColor,
                                        child: ListTile(
                                          leading: Icon(Icons.photo),
                                          title: Text("Gallery"),
                                          onTap: () {
                                            getImage(ImageSource.gallery);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        color: Theme.of(context).primaryColor,
                                        child: ListTile(
                                          leading: Icon(Icons.add_a_photo),
                                          title: Text("Camera"),
                                          onTap: () {
                                            getImage(ImageSource.camera);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                              showDialog(context: context, builder: (_) => ad);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Mr.${widget.profileModel.name}',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          padding:
                              const EdgeInsets.only(left: 8.0, bottom: 4.0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "User Information",
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Card(
                          child: Container(
                            // alignment: Alignment.topLeft,
                            padding: EdgeInsets.all(15),
                            child: Column(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    ...ListTile.divideTiles(
                                      color: Colors.grey,
                                      tiles: [
                                        ListTile(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 4),
                                          leading: Icon(
                                              Icons.drive_file_rename_outline),
                                          title: Text("User name"),
                                          subtitle: Text(
                                              "${widget.profileModel.name}"),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.email),
                                          title: Text("Email"),
                                          subtitle: Text(
                                              "${widget.profileModel.email}"),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.phone),
                                          title: Text("Phone"),
                                          subtitle: Text(
                                              "${widget.profileModel.phoneNum}"),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
