import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/common/components.dart';
import 'package:project/common/theme_helper.dart';
import 'package:project/network_utils/dio_helper.dart';
import 'package:project/screens/category/bloc/category_bloc.dart';
import 'package:project/screens/category/category.dart';
import 'package:project/screens/category/dio_helper_category.dart';
import 'package:project/screens/edit_category/bloc/edit_category_bloc.dart';

class EditCategory extends StatefulWidget {
  @required dynamic idCategory;
   EditCategory({Key key,this.idCategory}) : super(key: key);

  @override
  _EditCategoryState createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  EditCategoryBloc editCategoryBloc;
  CategoryBloc categoryBloc;
  var categoryController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryBloc=CategoryBloc(dioHelperCategory: DioHelperCategory());
    editCategoryBloc = EditCategoryBloc(dioHelper: DioHelper());
    categoryController.text = "";
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditCategoryBloc>(
      create: (BuildContext context) => editCategoryBloc,
      child: BlocConsumer<EditCategoryBloc, EditCategoryStates>(
          listener: (context, state) {
            if(state is EditCategorySuccessState){
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Category()));
    showToast(
    text: "Edit success", state: ToastStates.SUCCESS);
    }
          }, builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            toolbarHeight: 100,
            elevation: 0.1,
            title: Text(
               "Edit Category",
              style: TextStyle(
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold,
                  fontSize: 40),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Container(
                  child: Form(
                    key: _formKey,
                    child: //Category
                    TextFormField(
                      controller: categoryController,
                      keyboardType: TextInputType.name,
                      decoration: ThemeHelper().textInputProduct(
                          lableText: "Category",
                          hintText: "Enter of category ",
                          icon: Icon(Icons.category_rounded)),
                      validator: (val) {
                        if (val.isEmpty) {
                          return "You don\'t enter category!";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                BlocBuilder<EditCategoryBloc, EditCategoryStates>(
                    builder: (context, state) {
                      if (state is EditCategoryLoadingState) {
                        return const CircularProgressIndicator();
                      }
                      return Container(
                        decoration: ThemeHelper().buttonBoxDecoration(context),
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
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              editCategoryBloc.editCategory(name: categoryController.text, idCategory:"${widget.idCategory}");
                               }
                          },
                        ),
                      );
                    }),
              ],
            ),
          ),
        );
      }),
    );
  }
}
