import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/common/components.dart';
import 'package:project/network_utils/dio_helper.dart';
import 'package:project/screens/add_product/add_product.dart';
import 'package:project/screens/details_product/bloc/details_product_bloc.dart';
import 'package:project/screens/edit_product/edit_product.dart';
import 'package:project/screens/my_products/bloc/my_products_bloc.dart';
import 'package:project/screens/my_products/my_product_model.dart';
import 'package:project/screens/search/search.dart';
import 'package:project/widgets/buttonbar.dart';
import 'package:project/widgets/drawer.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import '../details_product/details_product.dart';

class MyProducts extends StatefulWidget {
  final String Nameeeeee;
   MyProducts({Key key,this.Nameeeeee}) : super(key: key);

  @override
  _MyProductsState createState() => _MyProductsState();
}

String dropdownValue="";
MyProductsBloc myProductsBloc;

class _MyProductsState extends State<MyProducts> {
  bool visibilityDate = false;
  final controller = ScrollController();
  final int counter = 0;
List<MyProductModel>list=[];
DetailsProductBloc detailsProductBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myProductsBloc=MyProductsBloc(dioHelper: DioHelper());
    myProductsBloc.myProductFun();
  }

  @override
  Widget build(BuildContext context) {
    
    return BlocProvider<MyProductsBloc>(create: (BuildContext context)=>myProductsBloc,
    child: BlocConsumer<MyProductsBloc,MyProductsStates>(listener: (context,state){
      if(state is MyProductsSuccessState)
        list=state.list;

    },
    builder: (context,state){

    return Scaffold(
      drawer: DrawerProduct(),
      appBar: ScrollAppBar(
          toolbarHeight: 80,
          controller: controller,
          centerTitle: true,
          elevation: 0.5,
          backgroundColor: Colors.white,
          title: Text(
            "My Product",
            style: TextStyle(
                color: Colors.deepOrange,
                fontSize: 40,
                fontWeight: FontWeight.bold),
          )),
      body: Container(
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        child: list.length == 0
            ? Center(
                child: Text(
                "You don't have any products.",
                style: TextStyle(fontSize: 30),
              ))
            : GridView(
                controller: controller,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 6,
                  mainAxisExtent: 260,
                  crossAxisCount: 2,
                ),
                children: List.generate(list.length, (index) {
                  return GestureDetector(
                    onLongPress: () {
                      var ad = AlertDialog(
                        title: Text("Choose one of options:"),
                        content: Container(
                          height: 175,
                          child: Column(
                            children: [
                              Divider(
                                height: 10,
                              ),
                              Container(
                                color: Theme.of(context).primaryColor,
                                child: ListTile(
                                  leading: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  title: Text(
                                    "Delete",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onTap: () {
                                    myProductsBloc.deleteProductFun(idProduct: "${list[index].id}");
                                    showToast(
                                        text: "Delete success",
                                        state: ToastStates.SUCCESS);
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
                                  leading: Icon(
                                    Icons.edit,
                                    color: Colors.green,
                                  ),
                                  title: Text(
                                    "Edit",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>EditProduct(idProduct: list[index].id,name: list[index].name ,quantity: list[index].quantity,price: list[index].mainPrice,),
                                        ));
                                  },
                                ),
                              ),
                              GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 150,
                                      ),
                                      Text(
                                        "Go back",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.grey,
                                      )
                                    ],
                                  ),
                                ),
                                onTap: () => Navigator.of(context).pop(),
                              )
                            ],
                          ),
                        ),
                      );
                      showDialog(context: context, builder: (_) => ad);
                    },
                    onTap:() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsProduct(idCategory: "${list[index].categoryId}",idProduct: list[index].id,image: "${list[index].image}",name:"${list[index].name}",quantity: "${list[index].quantity}",views: list[index].views,price: list[index].currentPrice,reacts: list[index].reacts,date: "${list[index].endDate}",owner_phone_num: "${list[index].ownerPhoneNum}",),
                        ));},
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26, width: 1)),
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(3),
                      child: Column(
                        children: [
                          Container(
                            height: 180,
                             child:  //Image.network("https://cdn.pixabay.com/photo/2018/01/14/23/12/nature-3082832_960_720.jpg",fit: BoxFit.fill,),

                      Image.network(
                                 "http://192.168.43.180:8000${list[index].image}",fit: BoxFit.fill,),
                            //    // //File('/data/user/0/com.example.project/cache/image_picker1733050951.jpg')
                            //    //     File('/data/user/0/com.example.project/cache/image_picker651088112.png')
                            // ),
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                          ),
                          Divider(
                            height: 10,
                          ),
                          Container(
                            child: Text(
                                  '${list[index].name}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 20),
                                ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2)),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
      ),
      bottomNavigationBar: BottomBar(
        v: false,
        v1: false,
        v2: true,
        v3: false,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Searching(Nameeee: widget.Nameeeeee,)));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );},
    ),

    );

  }
}
