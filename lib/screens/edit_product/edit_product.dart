import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:project/common/components.dart';
import 'package:project/common/theme_helper.dart';
import 'package:project/network_utils/dio_helper.dart';
import 'package:project/screens/add_product/add_prodduct_model.dart';
import 'package:project/screens/add_product/bloc/add_product_bloc.dart';
import 'package:project/screens/edit_product/bloc/edit_product_bloc.dart';
import 'package:project/screens/edit_product/edit_product_model.dart';
import 'package:project/screens/products/products.dart';
import 'package:project/widgets/header_widget.dart';


class EditProduct extends StatefulWidget {
  @required dynamic idProduct;
  @required dynamic name;
  @required dynamic quantity;
  @required dynamic price;
  @required dynamic date1;
  @required dynamic price1;
  @required dynamic date2;
  @required dynamic price2;
  @required dynamic date3;
  @required dynamic price3;
  @required dynamic image;






  EditProduct({Key key,this.idProduct,this.name,this.quantity,this.price,this.date1,this.price1,this.date2,this.price2,this.date3,this.price3,this.image}) : super(key: key);
  @override
  _EditProductState createState() => _EditProductState();
}

var nameController=TextEditingController();
var categoryController=TextEditingController();
var quantityController=TextEditingController();
var priceController=TextEditingController();


var expiryFirstController = TextEditingController();
var  expirySecondController= TextEditingController();
var expiryThirdController = TextEditingController();

var percentFirstController = TextEditingController();
var percentSecondController = TextEditingController();
var percentThirdController = TextEditingController();
AddProductBloc addProductBloc;
AddProductModel addProductModel;


class _EditProductState extends State<EditProduct> {
EditProductModel editProductModel;
EditProductBloc editProductBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
editProductBloc=EditProductBloc(dioHelper: DioHelper());
    percentFirstController.text="";
    percentSecondController.text="";
    percentThirdController.text="";
    nameController.text=widget.name;
    quantityController.text="${widget.quantity}";
    priceController.text="${widget.price}";
    expiryFirstController.text = "";
    expirySecondController.text = "";
    expiryThirdController.text = "";
  }

  File image;
  Future getImage (ImageSource src) async{
    final pickerFile=await ImagePicker().getImage(source: src);
    setState(() {
      if(pickerFile !=null){
        image=File(pickerFile.path);
      }
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditProductBloc>(create: (BuildContext context) => editProductBloc,
        child: BlocConsumer<EditProductBloc, EditProductStates>(listener: (context, state) {
          if (state is EditProductSuccessState) {

            if (state.editProductModel.status!=null) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Products()));
              showToast(text: state.editProductModel.msg, state: ToastStates.SUCCESS);

            }
          }
          else if(state is EditProductErrorState) {
            showToast(text:state.editProductModel.msg, state: ToastStates.ERROR);
          }
        }, builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                      height: 150,
                      child: HeaderWidget(
                          height: 160,
                          icon: Icons.add_comment_outlined,
                          visibility: false)),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 50, 0, 10),
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    // alignment: Alignment.center,
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            "Edit the product",
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(height: 30),
                              //Name
                              TextFormField(
                                controller: nameController,
                                keyboardType: TextInputType.name,
                                decoration: ThemeHelper().textInputProduct(
                                    lableText: 'Name',
                                    hintText: 'Enter name product',
                                    icon: Icon(Icons.drive_file_rename_outline)),
                              ),
                              //   SizedBox(height: 20),

                              SizedBox(height: 20),

                              //Quantity Available
                              TextFormField(
                                controller: quantityController,
                                keyboardType: TextInputType.number,
                                decoration: ThemeHelper().textInputProduct(
                                    lableText: "Quantity available",
                                    hintText: "Enter the quantity available of product.",
                                    icon: Icon(Icons.event_available)),
                              ),
                              SizedBox(height: 20),
                              //price
                              TextFormField(
                                controller: priceController,
                                keyboardType: TextInputType.number,
                                decoration: ThemeHelper().textInputProduct(
                                    lableText: "Price",
                                    hintText: "Enter the price",
                                    icon: Icon(Icons.money_off_csred_outlined)),
                              ),

                                    SizedBox(height: 20),
                                  ],)),
                              //Discount percentage
                              Stack(
                                children: [
                                  //Image
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height / 1.8,
                                    child: Image.asset("assets/sale4.jpg",fit: BoxFit.cover,),
                                  ),

                                  Container(
                                    padding: EdgeInsets.fromLTRB(0, 20, 10, 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10)),
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height / 2.1,
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Text(
                                            "Discount percentage",
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context).accentColor),
                                          ),
                                          SizedBox(height: 20),
                                          //First
                                          Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                width: MediaQuery.of(context).size.width / 2.2,
                                                height: 70,
                                                child: TextFormField(
                                                  controller: expiryFirstController,
                                                  decoration: ThemeHelper().textInputProduct(
                                                      lableText: "Expiry date1",
                                                      hintText: "Chose the expiry date! ",
                                                      icon: Icon(Icons.date_range)),

                                                  //set it true, so that user will not able to edit text
                                                  onTap: () async {
                                                    DateTime pickedDate = await showDatePicker(
                                                        builder: (BuildContext context, Widget child) {
                                                          return buildThemeDatePicker(context, child);
                                                        },
                                                        context: context,
                                                        initialDate: DateTime.now(),
                                                        firstDate: DateTime(2021),
                                                        //DateTime.now() - not to allow to choose before today.
                                                        lastDate: DateTime(2023));

                                                    if (pickedDate != null) {
                                                      String formattedDate =
                                                      DateFormat('yyyy-MM-dd').format(pickedDate);
                                                      setState(() {
                                                        expiryFirstController.text =
                                                            formattedDate; //set output date to TextField value.
                                                      });
                                                    }
                                                  },
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                width: MediaQuery.of(context).size.width / 2.2,
                                                height: 70,
                                                child: TextFormField(

                                                  controller: percentFirstController,
                                                  keyboardType: TextInputType.number,
                                                  decoration: ThemeHelper().textInputProduct(
                                                    lableText: "Price1",
                                                    hintText: " Enter the price1",
                                                    icon: Icon(Icons.money_off_csred_outlined),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          //Second
                                          Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                width: MediaQuery.of(context).size.width / 2.2,
                                                height: 70,
                                                child: TextFormField(
                                                  controller: expirySecondController,

                                                  decoration: ThemeHelper().textInputProduct(
                                                      lableText: "Expiry date2",
                                                      hintText: "Chose the expiry date! ",
                                                      icon: Icon(Icons.date_range)),

                                                  //set it true, so that user will not able to edit text
                                                  onTap: () async {
                                                    DateTime pickedDate = await showDatePicker(
                                                        builder: (BuildContext context, Widget child) {
                                                          return buildThemeDatePicker(context, child);
                                                        },
                                                        context: context,
                                                        initialDate: DateTime.now(),
                                                        firstDate: DateTime(2021),
                                                        //DateTime.now() - not to allow to choose before today.
                                                        lastDate: DateTime(2023));

                                                    if (pickedDate != null) {
                                                      String formattedDate =
                                                      DateFormat('yyyy-MM-dd').format(pickedDate);
                                                      setState(() {
                                                        expirySecondController.text =
                                                            formattedDate; //set output date to TextField value.
                                                      });
                                                    }
                                                  },
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                width: MediaQuery.of(context).size.width / 2.2,
                                                height: 70,
                                                child: TextFormField(

                                                  controller: percentSecondController,
                                                  keyboardType: TextInputType.number,
                                                  decoration: ThemeHelper().textInputProduct(

                                                    lableText: "Price2",
                                                    hintText: " Enter the price2",

                                                    icon: Icon(Icons.money_off_csred_outlined),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          //Third
                                          Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                width: MediaQuery.of(context).size.width / 2.2,
                                                height: 70,
                                                child: TextFormField(
                                                  controller: expiryThirdController,

                                                  decoration: ThemeHelper().textInputProduct(
                                                      lableText: "Expiry date3",
                                                      hintText: "Chose the expiry date! ",
                                                      icon: Icon(Icons.date_range)),
                                                  //set it true, so that user will not able to edit text
                                                  onTap: () async {
                                                    DateTime pickedDate = await showDatePicker(
                                                        builder: (BuildContext context, Widget child) {
                                                          return buildThemeDatePicker(context, child);
                                                        },
                                                        context: context,
                                                        initialDate: DateTime.now(),
                                                        firstDate: DateTime(2021),
                                                        //DateTime.now() - not to allow to choose before today.
                                                        lastDate: DateTime(2023));

                                                    if (pickedDate != null) {
                                                      String formattedDate =
                                                      DateFormat('yyyy-MM-dd').format(pickedDate);
                                                      setState(() {
                                                        expiryThirdController.text =
                                                            formattedDate; //set output date to TextField value.
                                                      });
                                                    }
                                                  },
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                width: MediaQuery.of(context).size.width / 2.2,
                                                height: 70,
                                                child: TextFormField(

                                                  controller: percentThirdController,
                                                  keyboardType: TextInputType.number,
                                                  decoration: ThemeHelper().textInputProduct(

                                                    lableText: "Price3",
                                                    hintText: "Enter the  price3",

                                                    icon: Icon(Icons.money_off_csred_outlined),
                                                  ),

                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              ////ImagePicker
                              GestureDetector(
                                child: Container(
                                    width: MediaQuery.of(context).size.width - 150,
                                    height: 230,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey.shade100,
                                    ),
                                    child: Center(
                                      child: image == null
                                          ? Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Add Image',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold, fontSize: 30),
                                          ),
                                          Icon(
                                            Icons.add_a_photo,
                                            size: 50,
                                          )
                                        ],
                                      )
                                          : Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            image: DecorationImage(
                                                image: FileImage(image), fit: BoxFit.fill),
                                          )),
                                    )),
                                onTap: () {
                                  getImage(ImageSource.gallery);
                                },
                              ),

                              SizedBox(height: 35),
                              //Button Add now
                              BlocBuilder<EditProductBloc, EditProductStates>(
                                  builder: (context, state) {
                                    if (state is EditProductLoadingState) {
                                      return const CircularProgressIndicator();
                                    }
                                    return
                                      Container(
                                        decoration: ThemeHelper().buttonBoxDecoration(
                                            context),
                                        child: ElevatedButton(
                                          style: ThemeHelper().buttonStyle(),
                                          child: Padding(
                                              padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                              child: Text(
                                                "EDIT NOW",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              )
                                          ),
                                          onPressed: () {
                                            if (_formKey.currentState.validate()) {
                                              print(widget.idProduct);
                                              editProductBloc.editProductFun(
                                                idProduct:widget.idProduct,
                                                  name: nameController.text,
                                                  quantity: quantityController.text,
                                                  price: priceController.text,
                                                  expiry_date_f: expiryFirstController.text,
                                                  expiry_date_s: expirySecondController.text,
                                                  expiry_date_t: expiryThirdController.text,
                                                  price1: percentFirstController.text,
                                                  price2: percentSecondController.text,
                                                  price3: percentThirdController.text,
                                                  image: image
                                              );
                                            }
                                          },
                                        ),
                                      );
                                  })
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
               // ],
            //  ),
           // ),
          );

        },
        )
    );
  }

  Theme buildThemeDatePicker(BuildContext context, Widget child) {
    return Theme(
      data: ThemeData.light().copyWith(
        primaryColor:
        Theme.of(context).accentColor,
        accentColor:
        Theme.of(context).primaryColor,
        colorScheme: ColorScheme.light(
            primary:
            Theme.of(context).accentColor),
        buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme.primary),
      ),
      child: child,
    );
  }

}