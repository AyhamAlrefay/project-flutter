import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/common/components.dart';
import 'package:project/common/theme_helper.dart';
import 'package:project/network_utils/dio_helper.dart';
import 'package:project/screens/add_category/bloc/add_category_bloc.dart';
import 'package:project/screens/category/bloc/category_bloc.dart';
import 'package:project/screens/category/category.dart';
import 'package:project/screens/category/dio_helper_category.dart';


class AddCategory extends StatefulWidget {
  const AddCategory({Key key}) : super(key: key);

  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  AddCategoryBloc addCategoryBloc;
  CategoryBloc categoryBloc;
  var categoryController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryBloc=CategoryBloc(dioHelperCategory: DioHelperCategory());
    addCategoryBloc = AddCategoryBloc(dioHelper: DioHelper());
    categoryController.text = "";
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddCategoryBloc>(
      create: (BuildContext context) => addCategoryBloc,
      child: BlocConsumer<AddCategoryBloc, AddCategoryStates>(
          listener: (context, state) {

            if (state is AddCategorySuccessState) {
          if (state.addCategoryModel.status != null) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Category()));
            showToast(
                text: state.addCategoryModel.msg, state: ToastStates.SUCCESS);
          }
        } else if (state is AddCategoryErrorState) {
          showToast(text: AddCategoryBloc.errorState, state: ToastStates.ERROR);
        }
      }, builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            toolbarHeight: 100,
            elevation: 0.1,
            title: Text(
               "Add Category",
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
                BlocBuilder<AddCategoryBloc, AddCategoryStates>(
                    builder: (context, state) {
                  if (state is AddCategoryLoadingState) {
                    return const CircularProgressIndicator();
                  }
                  return Container(
                    decoration: ThemeHelper().buttonBoxDecoration(context),
                    child: ElevatedButton(
                      style: ThemeHelper().buttonStyle(),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                        child: Text(
                           "ADD NOW",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          addCategoryBloc.userAddCategory(name: categoryController.text);

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
