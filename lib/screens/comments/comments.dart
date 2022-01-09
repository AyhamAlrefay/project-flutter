
import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/network_utils/dio_helper.dart';
import 'package:project/screens/comments/bloc/comments_bloc.dart';
import 'package:project/shared/sharedpreferences.dart';
class TestMe extends StatefulWidget {
  @required var idProduct;
  TestMe(this.idProduct);
  @override
  _TestMeState createState() => _TestMeState();
}

class _TestMeState extends State<TestMe> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
var fileData=[];
CommentsBloc commentsBloc;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    commentsBloc=CommentsBloc(dioHelper: DioHelper());
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CommentsBloc>(create:(BuildContext context)=>commentsBloc,
    child: BlocConsumer<CommentsBloc,CommentsStates>(
      listener: (context,state){},
      builder: (context,state){


    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text("Comment Page",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(

        child: CommentBox(
          userImage:
          "https://picsum.photos/300/30",
          child: commentChild(fileData),
          labelText: 'Write a comment...',
          withBorder: false,
          errorText: 'Comment cannot be blank',
          sendButtonMethod: () {
            commentsBloc.commentFun(idProduct: "${widget.idProduct}", body: commentController.text);

            if (formKey.currentState.validate()) {
              print(commentController.text);
              setState(() {
                var value = {
                  'name': '${CacheHelper.getData(key: 'nameProfile')}',
                  'pic':
                  'https://picsum.photos/300/30',
                  'message': commentController.text
                };
                fileData.insert(0, value);
              });
              commentController.clear();
             // FocusScope.of(context).unfocus();
            } else {
              print("Not validated");
            }
          },
          formKey: formKey,
          commentController: commentController,
          backgroundColor: Colors.deepOrange,//black,
          textColor: Colors.white,//white,
          sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
        ),
      ),
    );
      },

    ),

    );
  }

  Widget commentChild(fileDate) {
    return ListView(

      children: [
        for (var i = 0; i < fileData.length; i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  // Display the image in large form.
                  print("Comment Clicked");
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: new BoxDecoration(
                      color: Colors.blue,
                      borderRadius: new BorderRadius.all(Radius.circular(50))),
                  child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(fileData[i]['pic'] + "$i")),               //(data[i]['pic'] + "$i")),
                ),
              ),
              title: Text(
                fileData[i]['name'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(fileData[i]['message']),
            ),
          )
      ],
    );
  }


}

