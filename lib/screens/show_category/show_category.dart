import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/network_utils/dio_helper.dart';
import 'package:project/screens/add_product/add_product.dart';
import 'package:project/screens/details_product/details_product.dart';
import 'package:project/screens/show_category/bloc/show_category_bloc.dart';
import 'package:project/screens/show_category/show_category_model.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class ShowCategory extends StatefulWidget {
  @required var idCategory;
  @required var nameCategory;
   ShowCategory({Key key,this.idCategory,this.nameCategory}) : super(key: key);

  @override
  _ShowCategoryState createState() => _ShowCategoryState();
}

final controller = ScrollController();
String dropdownValue;


class _ShowCategoryState extends State<ShowCategory> {
  ShowCategoryModel showCategoryModel;
  ShowCategoryBloc showCategoryBloc;

List<ShowCategoryModel> listShowCategory=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showCategoryBloc=ShowCategoryBloc(dioHelper: DioHelper());
    showCategoryBloc.showCategoryFun(idCategory: "${widget.idCategory}");
print(widget.idCategory);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShowCategoryBloc>(create: (BuildContext context)=>showCategoryBloc,
    child: BlocConsumer<ShowCategoryBloc,ShowCategoryStates>(
      listener: (context,state){
        if(state is ShowCategorySuccessState){
          listShowCategory=state.list;
        }

      },
      builder: (context,state){

if(listShowCategory.isEmpty)
  return Scaffold(
    body: Center(child: Text("You dont have any products here!\n\n                     Add now!",style: TextStyle(fontSize: 20),)),

    floatingActionButton: FloatingActionButton(
      child: Icon(Icons.add_shopping_cart),
      onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>AddProduct())),
    ),);
else

    return Scaffold(
      appBar: ScrollAppBar(
        controller: controller,
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          "${widget.nameCategory}",
          style: TextStyle(
              color: Colors.deepOrange,
              fontSize: 40,
              fontWeight: FontWeight.bold),
        ),
        toolbarHeight: 80,
        centerTitle: true,
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Center(
            child: GridView(
              controller: controller,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 6,
                crossAxisSpacing: 6,
                mainAxisExtent: 230,
                crossAxisCount: 2,
              ),
              children: List.generate(
                  listShowCategory.length,
                  (index) => InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsProduct(image: "${listShowCategory[index].image}",name :"${listShowCategory[index].name}",
                                  nameCategory:"${widget.nameCategory}",quantity: "${listShowCategory[index].quantity}"
                                  ,views: listShowCategory[index].views,price: listShowCategory[index].currentPrice,
                                  reacts: listShowCategory[index].reacts,date: "${listShowCategory[index].endDate}",
                                  owner_phone_num: "${listShowCategory[index].ownerPhoneNum}",idProduct: listShowCategory[index].id,
                                  idCategory: "${listShowCategory[index].categoryId}",),
                              ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border:
                                  Border.all(color: Colors.black26, width: 4)),
                          margin: EdgeInsets.all(10),
                          //padding: EdgeInsets.all(3),
                          child: Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height / 5,
                                width: MediaQuery.of(context).size.width,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image(
                                    image:
                                        NetworkImage("http://192.168.43.180:8000${listShowCategory[index].image}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Center(
                                child: Text(
                                  "${listShowCategory[index].name}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.deepOrange,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
            ),
          )),
floatingActionButton: FloatingActionButton(
  child: Icon(Icons.add_shopping_cart),
  onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>AddProduct())),
),
    );
      },
    ),

    );

  }
}
