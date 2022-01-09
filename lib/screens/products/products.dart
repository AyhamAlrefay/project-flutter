import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/screens/category/dio_helper_category.dart';
import 'package:project/screens/details_product/details_product.dart';
import 'package:project/screens/products/bloc/products_bloc.dart';
import 'package:project/screens/products/name_model.dart';
import 'package:project/screens/products/product_model.dart';
import 'package:project/screens/search/bloc/searching_bloc.dart';
import 'package:project/screens/search/search.dart';
import 'package:project/screens/search/search_model.dart';
import 'package:project/widgets/buttonbar.dart';
import 'package:project/widgets/drawer.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class Products extends StatefulWidget {
 final List<SearchModel> listSearch;
  Products({Key key,this.listSearch}) : super(key: key);
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {

  final controller = ScrollController();
ProductsBloc productsBloc;
  List <ProductsModel>list =[];
  List<dynamic>listName=[];
  List<ProductsModel>list_sort=[];
  bool sorting=false;
  Color color=Colors.grey;
  SearchingBloc searchingBloc;
  int x=1;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    productsBloc=ProductsBloc(dioHelperCategory: DioHelperCategory());
  productsBloc.AllProducts();
  productsBloc.listFun();

  }
String nameForSearch="";
  String func(List <NameModel> list){
  for(int i=0;i<list.length;i++)
    {nameForSearch=nameForSearch +"  ${list[i].name}  ";
}

    return nameForSearch;
  }
  String nameee="";
  @override
  Widget build(BuildContext context) {
   return
   BlocProvider<ProductsBloc>(
   create: (BuildContext context) => productsBloc,
   child: BlocConsumer<ProductsBloc, ProductsStates>(
    listener: (context, state) {
      if(state is ProductsSuccessState)
       {
         list=state.list;
         list_sort=[];
       }
      if(state is ProductsSortSuccessState)
      {
        list=[];
        list_sort=state.listSort;
      }

    if(state is NameSuccessState) {
      listName = state.list;
      nameee=func(listName);
      print(nameee);
    }




    },
    builder: (context, state) {

    return
      Scaffold(
        drawer: DrawerProduct(),
        appBar: ScrollAppBar(
          backgroundColor: Colors.white,
          /////sorting
          actions: [GestureDetector(
            child: Row(
              children: [
                Text("Sorting",style: TextStyle(color: color,fontSize: 20),),
                Icon(Icons.sort,color: color,),
              ],),
            onTap: (){
             setState(() {
               sorting=!sorting;
               color =sorting?Colors.deepOrange:Colors.grey;
             });
               if (sorting==true) {
                 list_sort=[];
                 list=[];
                 productsBloc.sortingProducts();

               }
               if(sorting==false) {
                 list=[];
                 list_sort=[];
                 productsBloc.AllProducts();
               }


            },
          ),],
          toolbarHeight: 80,
          elevation: 0.5,
          controller: controller,
          centerTitle: true,
          title: Text('CartShop',
              style: TextStyle(color: Colors.deepOrange,fontSize: 40, fontWeight: FontWeight.bold)),

        ),
        body: Container(
            padding: EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
             child:

              GridView(
                  controller: controller,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 6,
                    mainAxisExtent: 260,
                    crossAxisCount: 2,
                  ),
                  children:
                  list_sort.length==0 && widget.listSearch==null ? List.generate(
                   list.length   ,
                          (index) => InkWell(
                        onTap: () {

                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsProduct(idCategory: "${list[index].categoryId}",image: "${list[index].image}",name:"${list[index].name}",quantity: "${list[index].quantity}",views: list[index].views,price: list[index].currentPrice,reacts: list[index].reacts,date: "${list[index].endDate}",owner_phone_num: "${list[index].ownerPhoneNum}",idProduct: list[index].id,),));},

                        child: Container(
                          decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topRight:Radius.circular(20),topLeft: Radius.circular(20)),
                              border:
                              Border.all(color: Colors.black54, width: 3)),
                          margin: EdgeInsets.all(10),
                          //padding: EdgeInsets.all(3),
                          child: Column(
                            children: [
                              Container(
                                height: 180,
                                child:ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                    child:Image(

                                     image: NetworkImage("http://192.168.43.180:8000${list[index].image}"),

                                      fit: BoxFit.fill,
                                )),
                                width: double.maxFinite,
                              ),
                              Divider(height: 10),
                              Container(
                                child: Container(
                                  width:MediaQuery.of(context).size.width/4,

                                  child: Text(
                                    "${list[index].name}",
                                    //textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20,color: Colors.deepOrange),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                // decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(2)),
                              ),
                            ],
                          ),
                        ),
                      )):
                      widget.listSearch==null?
                  List.generate(
                      list_sort.length   ,
                          (index) => InkWell(
                        onTap: () {

                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsProduct(idProduct: list_sort[index].id,idCategory: "${list_sort[index].categoryId}",image: "${list_sort[index].image}",name:"${list_sort[index].name}",quantity: "${list_sort[index].quantity}",views: list_sort[index].views,price: list_sort[index].currentPrice,reacts: list_sort[index].reacts,date: "${list_sort[index].endDate}",owner_phone_num: "${list_sort[index].ownerPhoneNum}",),));},

                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topRight:Radius.circular(20),topLeft: Radius.circular(20)),
                              border:
                              Border.all(color: Colors.black54, width: 3)),
                          margin: EdgeInsets.all(10),
                          //padding: EdgeInsets.all(3),
                          child: Column(
                            children: [
                              Container(
                                height: 180,
                                child:ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child:Image(

                                      image: NetworkImage("http://192.168.43.180:8000${list_sort[index].image}"),

                                      fit: BoxFit.fill,
                                    )),
                                width: double.maxFinite,
                              ),
                              Divider(height: 10),
                              Container(
                                child: Container(
                                  width:MediaQuery.of(context).size.width/4,

                                  child: Text(
                                    "${list_sort[index].name}",
                                    //textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20,color: Colors.deepOrange),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                // decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(2)),
                              ),
                            ],
                          ),
                        ),
                      )):
                      List.generate(
                          widget.listSearch.length   ,
                              (index) => InkWell(
                            onTap: () {

                              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsProduct(idProduct:widget.listSearch[index].id,
                                idCategory: "${widget.listSearch[index].categoryId}",
                                image: "${widget.listSearch[index].image}",
                                name:"${widget.listSearch[index].name}",
                                quantity: "${widget.listSearch[index].quantity}",
                                views: widget.listSearch[index].views,
                                price: widget.listSearch[index].currentPrice,
                                reacts: widget.listSearch[index].reacts,
                                date: "${widget.listSearch[index].endDate}",
                                owner_phone_num: "${widget.listSearch[index].ownerPhoneNum}",),));},

                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topRight:Radius.circular(20),topLeft: Radius.circular(20)),
                                  border:
                                  Border.all(color: Colors.black54, width: 3)),
                              margin: EdgeInsets.all(10),
                              //padding: EdgeInsets.all(3),
                              child: Column(
                                children: [
                                  Container(
                                    height: 180,
                                    child:ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child:Image(

                                          image: NetworkImage("http://192.168.43.180:8000${widget.listSearch[index].image}"),

                                          fit: BoxFit.fill,
                                        )),
                                    width: double.maxFinite,
                                  ),
                                  Divider(height: 10),
                                  Container(
                                    child: Container(
                                      width:MediaQuery.of(context).size.width/4,

                                      child: Text(
                                        "${widget.listSearch[index].name}",
                                        //textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 20,color: Colors.deepOrange),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    // decoration: BoxDecoration(
                                    //     borderRadius: BorderRadius.circular(2)),
                                  ),
                                ],
                              ),
                            ),
                          ))

                ),
              //},
            //)

        ),
      bottomNavigationBar: BottomBar(v: false,v1: true,v2: false,v3: false,nameee: nameee,),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Searching(Nameeee: nameee,)));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }));
}}