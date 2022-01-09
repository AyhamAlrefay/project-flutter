import 'package:flutter/material.dart';
import 'package:project/screens/add_category/AddCategory.dart';
import 'package:project/screens/add_product/add_product.dart';
import 'package:project/screens/category/category.dart';
import 'package:project/screens/my_products/my_product.dart';
import 'package:project/screens/products/products.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  final bool v;
  final bool v1;
  final bool v2;
  final bool v3;
final  String nameee;
   BottomBar({
    Key key,
    this.v,
    this.v1,
    this.v2,
    this.v3,
     this.nameee
  }) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

  bool visibilityDate=false;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 6,
      color: Colors.transparent,
      elevation: 9,
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0)),
            color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                height: 50,
                width: MediaQuery.of(context).size.width / 2 - 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.home,
                          color: widget.v ? Colors.deepOrange : Colors.black54),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => Category(Nameeee: widget.nameee,)));
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.shop_two,
                          color: widget.v1 ? Colors.deepOrange : Colors.black54),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => Products()));
                      },
                    ),
                  ],
                )),
            Container(
                height: 50,
                width: MediaQuery.of(context).size.width / 2 - 40.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.shop_outlined,
                          color: widget.v2 ? Colors.deepOrange : Colors.black54),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MyProducts(Nameeeeee: widget.nameee,)));
                      },
                    ),
                    IconButton(
                        icon: Icon(Icons.add_shopping_cart,
                            color: widget.v3 ? Colors.deepOrange : Colors.black54),
                        onPressed: () {
                          setState(() {
                            visibilityDate=true;
                          });
                          Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => AddCategory()));
                        })
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
