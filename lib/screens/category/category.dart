import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/common/components.dart';
import 'package:project/screens/category/bloc/category_bloc.dart';
import 'package:project/screens/category/category_model.dart';
import 'package:project/screens/category/dio_helper_category.dart';
import 'package:project/screens/edit_category/bloc/edit_category_bloc.dart';
import 'package:project/screens/edit_category/edit_category.dart';
import 'package:project/screens/one_category/one_category_model.dart';
import 'package:project/screens/search/search.dart';
import 'package:project/screens/show_category/show_category.dart';
import 'package:project/shared/sharedpreferences.dart';
import 'package:project/widgets/buttonbar.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class Category extends StatefulWidget {
  final String Nameeee;
   Category({Key key,this.Nameeee}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

String dropdownValue = "";
bool visibilityDate = false;
CategoryBloc categoryBloc;
CategoryModel categoryModel;
EditCategoryBloc editCategoryBloc;

class _CategoryState extends State<Category> {
  final controller = ScrollController();
  List listName = [];
  List listId = [];
  var nameCategory="";
OneCategoryModel oneCategoryModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryBloc = CategoryBloc(dioHelperCategory: DioHelperCategory());
    categoryBloc.AllCategory();

// list=categoryModel.data;
  }

  @override
  Widget build(BuildContext context) {
    CategoryModel categoryModel;
    return BlocProvider<CategoryBloc>(
      create: (BuildContext context) => categoryBloc,
      child: BlocConsumer<CategoryBloc, CategoryStates>(
        listener: (context, state) {
          if (state is CategorySuccessState) {
            listName = state.listName;
            listId = state.listId;
          }
          if (state is OneCategorySuccessStates)
            nameCategory=oneCategoryModel.name;
        },
        builder: (context, state) {
          return Scaffold(
            appBar: ScrollAppBar(
              backgroundColor: Colors.white,
              toolbarHeight: 80,
              elevation: 0.2,
              controller: controller,
              centerTitle: true,
              title: Text(
                "Category",
                style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: SafeArea(
              child: Container(
                  padding: EdgeInsets.all(20),
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white,
                  child: Center(
                    child: GridView(
                      controller: controller,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 6,
                        crossAxisSpacing: 6,
                        mainAxisExtent: 200,
                        crossAxisCount: 2,
                      ),
                      children: List.generate(
                          listName.length, // categoryModel.data.length,
                          (index) => GestureDetector(
                                onLongPress: () {
                                  categoryBloc.oneCategory(listName[index]);
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
                                            color:
                                                Theme.of(context).primaryColor,
                                            child: ListTile(
                                              leading: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                              title: Text(
                                                "Delete",
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              onTap: () {
                                                categoryBloc.deletCategory(
                                                    "${listId[index]}");
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
                                            color:
                                                Theme.of(context).primaryColor,
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
                                                CacheHelper.saveData(key: "idCategory", value:listId[index]);

                                             //  categoryBloc.editCategory(name: "${listName[index]}", idCategory: "${listId[index]}");
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditCategory(idCategory: listId[index],),
                                                    ));
                                              },
                                            ),
                                          ),
                                          GestureDetector(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 150,
                                                  ),
                                                  Text(
                                                    "Go back",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.grey),
                                                  ),
                                                  Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: Colors.grey,
                                                  )
                                                ],
                                              ),
                                            ),
                                            onTap: () =>
                                                Navigator.of(context).pop(),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                  showDialog(
                                      context: context, builder: (_) => ad);
                                },
                                onTap: () {
                                  CacheHelper.saveData(key: "idCategory", value:listId[index]);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ShowCategory(idCategory:listId[index],nameCategory: listName[index],),
                                      ));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.deepOrange.shade400,
                                          Theme.of(context).primaryColor
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                          color: Colors.black26, width: 4)),
                                  margin: EdgeInsets.all(10),
                                  //padding: EdgeInsets.all(3),
                                  child: Container(
                                    child: Center(
                                      child: Text(
                                        "${listName[index]}",
                                        //     "${categoryModel.data[index].name}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                    ),
                  )),
            ),
            bottomNavigationBar: BottomBar(
              v: true,
              v1: false,
              v2: false,
              v3: false,
              nameee: widget.Nameeee,
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.search),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Searching(Nameeee:widget.Nameeee ,)));
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          );
        },
      ),
    );
  }
}
