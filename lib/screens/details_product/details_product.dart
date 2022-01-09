import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:project/network_utils/dio_helper.dart';
import 'package:project/screens/category/bloc/category_bloc.dart';
import 'package:project/screens/category/category.dart';
import 'package:project/screens/category/dio_helper_category.dart';
import 'package:project/screens/comments/comments.dart';
import 'package:project/screens/details_product/bloc/details_product_bloc.dart';
import 'package:project/screens/one_category/one_category_model.dart';
import 'package:project/shared/sharedpreferences.dart';
import 'package:project/widgets/header_widget.dart';


class DetailsProduct extends StatefulWidget {
  @required var idCategory;
  @required String name;
  @required String nameCategory;
  @required var idProduct;
  @required var price;
  @required var date;
  @required var quantity;
  @required var reacts;
  @required var views;
  @required  var image;
  @required var owner_phone_num;
  DetailsProduct({this.idCategory,this.name,this.idProduct,this.nameCategory,this.image,this.quantity,this.price,this.owner_phone_num,this.date,this.views,this.reacts,});
  @override
  _DetailsProductState createState() => _DetailsProductState();
}

class _DetailsProductState extends State<DetailsProduct> {

  bool isLiked=false;
 CategoryBloc categoryBloc;
 OneCategoryModel oneCategoryModel;
  DetailsProductBloc detailsProductBloc;

  @override
  void initState() {
    super.initState();
  detailsProductBloc=DetailsProductBloc(dioHelper: DioHelper());
  categoryBloc=CategoryBloc(dioHelperCategory: DioHelperCategory());
  categoryBloc.oneCategory("${widget.idCategory}");
  detailsProductBloc.detailsProductFun(name:widget.name);
  detailsProductBloc.likesFun(idProduct: "${widget.idProduct}");
  // bool isLiked=widget.reacts==1?true:false;
    }
  String name1Category="";

  var ve=0;
  bool like = false;
  IconData icon = Icons.favorite_border;



  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
    BlocProvider<DetailsProductBloc>(create:(BuildContext context)=>detailsProductBloc,),
    BlocProvider<CategoryBloc>(create: (BuildContext context) => categoryBloc,),
    ],
    child: BlocConsumer<DetailsProductBloc,DetailsProductStates>(
      listener: (context,state){
        if(state is DetailsProductSuccessState)
        {  ve=state.a;}
        if(state is DetailsProductsLikesSuccessState)
          {



           if(state.likesModel.msg=="like"|| state.likesModel.msg=="New table")
          {
          icon = Icons.favorite;
          like = true;
          // CacheHelper.saveData(key: 'icon', value: true);
          // CacheHelper.saveData(key: 'like', value: widget.idProduct);
          CacheHelper.saveData(key: '${widget.idProduct}', value: like);

          isLiked=CacheHelper.getData(key: "${widget.idProduct}");;
          }
               if(state.likesModel.msg=="dislike")
             {
               icon = Icons.favorite_border;
               like = false;
               // CacheHelper.saveData(key: 'icon', value: false);
               // CacheHelper.saveData(
               //     key: 'like', value: widget.idProduct);
               CacheHelper.saveData(
                   key: '${widget.idProduct}', value: like);
               isLiked=CacheHelper.getData(key: "${widget.idProduct}");


             }
          }

          },
      builder:(context,state){

        return Scaffold(

      //bottomNavigationBar: BottomBar1(),
      body: SafeArea(
        child: Container(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: 150,
                  child:Stack(children:[ HeaderWidget(
                      height: 140,
                      icon: Icons.add_comment_outlined,
                      visibility: false),
                    BlocConsumer<CategoryBloc,CategoryStates>( listener: (context,state){
if(state is OneCategorySuccessStates)
 { name1Category=state.nameCategory;}
                      },
                        builder: (context,state){
                      return
                    Center(child: Text("$name1Category",
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 40),));})])),

              SizedBox(height: 10,),
              Card(

                child: Column(
                  children: [
                           Container(
                            //  padding: EdgeInsets.all(10),
                              height: MediaQuery.of(context).size.height / 2.5,
                              width: MediaQuery.of(context).size.width -50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                                border:
                                    Border.all(color: Colors.black26, width: 2),
                                image: DecorationImage(
                                  image: NetworkImage("http://192.168.43.180:8000${widget.image}"),
                                  fit: BoxFit.fill,
                                ),
                              )),
                    Container(
                      width: MediaQuery.of(context).size.width/1.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: isLiked?Icon(Icons.favorite, size:35, color: Colors.deepOrange[600])
                                : Icon(Icons.favorite_border, size:30, color:Colors.grey,),
                            // onPressed: () {setState(() {
                            //   isLiked=!isLiked;
                            // });}
                            onPressed: (){
                              print(widget.idProduct);
                              detailsProductBloc.likesFun(idProduct: widget.idProduct);
                            },

                          ),
                          Text("${widget.price}\$",style: TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),),
                          Row(

                            children: [
                            Icon(Icons.visibility),
                            SizedBox(width: 5,),
                            Text("$ve"),
                          ],)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              //Name
              SizedBox(
                height: 50,
                child: Text(
                  "${widget.name}",
                  style: TextStyle(
                      fontSize: 35,
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 35),
              Container(

                padding: EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Quantity: ",
                                style: TextStyle(
                                    color: Colors.deepOrange.withOpacity(0.9),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              Text(
                                  "${widget.quantity}",
                                  style: TextStyle(fontSize: 18)),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "ExpiryDate:",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.deepOrange.withOpacity(0.9)),
                              ),
                              Text(
                                "${widget.date}",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),

                    ]
                  ),
                ),
                height: 80,
                width: double.infinity,
                color: Colors.grey.shade200,
              ),

              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.all(20),
                child: Center(
                    child: Column(
                  children: [
                    Text(
                      " You can buy it directly by contacting us via: ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.deepOrange.withOpacity(0.9)),
                    ),
                    Text(
                      " \n${widget.owner_phone_num}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black),
                    )
                  ],
                )),
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey.shade200,
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        )),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.message),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) =>TestMe("${widget.idProduct}"))),
      ),
    );
      } ,
    ),
    );
  }
}
