import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/common/components.dart';
import 'package:project/common/theme_helper.dart';
import 'package:project/screens/products/products.dart';
import 'package:project/screens/search/bloc/searching_bloc.dart';
import 'package:project/screens/search/diohelper_search.dart';
import 'package:project/screens/search/search_model.dart';
import 'package:search_choices/search_choices.dart';

class ExampleNumber {
  int number=0;
  static final Map<int, String> map = {
    0: "zero",
    1: "one",
    2: "two",
    3: "three",
    4: "four",
    5: "five",
    6: "six",
    7: "seven",
    8: "eight",
    9: "nine",
    10: "ten",
    11: "eleven",
    12: "twelve",
    13: "thirteen",
    14: "fourteen",
    15: "fifteen",
  };

  String get numberString {
    return ((map.containsKey(number) ? map[number] : "unknown") ?? "unknown");
  }

  ExampleNumber(this.number);

  static List<ExampleNumber> get list {
    return (map.keys.map((num) {
      return (ExampleNumber(num));
    })).toList();
  }
}

class Searching extends StatefulWidget {

final String Nameeee;
  static final navKey = new GlobalKey<NavigatorState>();

   Searching({Key navKey,this.Nameeee}) : super(key: navKey);

  @override
  _SearchingState createState() => _SearchingState();
}

class _SearchingState extends State<Searching> {

  SearchingBloc searchingBloc;


  bool asTabs = false;
  String selectedValueName="";
  String selectedValueCategory="";
  String selectedValueExpiryDate="";
  List<DropdownMenuItem> items = [];
  final _formKey = GlobalKey<FormState>();
  String inputString = "";
  TextFormField input=TextFormField();
  List<DropdownMenuItem<ExampleNumber>> numberItems =
      ExampleNumber.list.map((exNum) {
    return (DropdownMenuItem(child: Text(exNum.numberString), value: exNum));
  }).toList();


     // " iphone  ibad  fruit  orange  Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

  @override
  void initState() {
searchingBloc=SearchingBloc(dioHelperSearch: DioHelperSearch());
final String loremIpsum =widget.Nameeee;
    String wordPair = "";
    loremIpsum.toLowerCase().replaceAll(",", "").replaceAll(".", "").split(" ").forEach((word) {
      if (wordPair.isEmpty) {
        wordPair = word + " ";
      } else {
        wordPair += word;
        if (items.indexWhere((item) {
              return (item.value == wordPair);
            }) == -1) {
          items.add(DropdownMenuItem(
            child: Text(wordPair),
            value: wordPair,
          ));
        }
        wordPair = "";
      }
    });
    input = TextFormField(
      validator: (value) {
        return ((value?.length ?? 0) < 6
            ? "must be at least 6 characters long"
            : null);
      },
      initialValue: inputString,
      onChanged: (value) {
        inputString = value;
      },
      autofocus: true,
    );
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Map<String, Widget> widgets;
    widgets = {
      "Search by name": SearchChoices.single(
        items: items,
        value: selectedValueName,
        hint: "Select one",
        searchHint: "Select one",
        onChanged: (value) {
          setState(() {
            selectedValueName = value;
          });
        },
        isExpanded: true,
      ),
      // "Search by category": SearchChoices.single(
      //   items: items,
      //   value: selectedValueCategory,
      //   hint: "Select one",
      //   searchHint: "Select one",
      //   onChanged: (value) {
      //     setState(() {
      //       selectedValueCategory = value;
      //     });
      //   },
      //   isExpanded: true,
      // ),
      // "Search by expiry date": SearchChoices.single(
      //   items: items,
      //   value: selectedValueExpiryDate,
      //   hint: "Select one",
      //   searchHint: "Select one",
      //   onChanged: (value) {
      //     setState(() {
      //       selectedValueExpiryDate = value;
      //     });
      //   },
      //   isExpanded: true,
      // ),
    };
List <SearchModel> list_search=[] ;
    return BlocProvider<SearchingBloc>(create: (BuildContext context)=>searchingBloc,
      child: BlocConsumer<SearchingBloc,SearchingStates>(
          listener: (context,state){
            if(state is SearchingSuccessState) {
              list_search = state.list;

              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Products(listSearch:list_search,)));
            }
if(state is SearchingErrorState)
  showToast(text: "product doesn't exist .", state: ToastStates.ERROR);
          },
          builder: (context,state){

    return  Scaffold(
              appBar: AppBar(
          backgroundColor:Colors.deepOrange ,
                title: const Text("Searching...",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
              ),
              body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: widgets.map((k, v) {
                        return (MapEntry(k,
                            Center(
                                child:

                               Column(children: [Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40),
                                      side: BorderSide(
                                        color: Colors.grey,
                                        width: 1.0,
                                      ),
                                    ),
                                    margin: EdgeInsets.all(20),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        children: <Widget>[
                                          Text("$k:",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.deepOrange),),
                                          v,
                                        ],
                                      ),
                                    )),

   Container(
    decoration: ThemeHelper()
        .buttonBoxDecoration(context),
    child: ElevatedButton(
        style: ThemeHelper().buttonStyle(),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              40, 10, 40, 10),
          child: Text(
            'SEARCHING',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        onPressed: () {
          print(selectedValueName.replaceAll(' ', '').toString());
          searchingBloc.searchingFun(name: selectedValueName.replaceAll(' ', ''));
          print(k);
          // if (_formKey.currentState
          //     .validate()) {}
        }),)


                            ],)

                            )

                        ));
                      }).values.toList()..add(
                          Center(child: SizedBox(height: 500),),
                        ), //prevents scrolling issues at the end of the list of Widgets
                ),
              ),

    );

      }),

    );
  }
}


/*









import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/common/components.dart';
import 'package:project/common/theme_helper.dart';
import 'package:project/screens/products/products.dart';
import 'package:project/screens/search/bloc/searching_bloc.dart';
import 'package:project/screens/search/search_model.dart';
import 'package:search_choices/search_choices.dart';

class ExampleNumber {
  int number;

  static final Map<int, String> map = {
    0: "zero",
    1: "one",
    2: "two",
    3: "three",
    4: "four",
    5: "five",
    6: "six",
    7: "seven",
    8: "eight",
    9: "nine",
    10: "ten",
    11: "eleven",
    12: "twelve",
    13: "thirteen",
    14: "fourteen",
    15: "fifteen",
  };

  String get numberString {
    return ((map.containsKey(number) ? map[number] : "unknown") ?? "unknown");
  }

  ExampleNumber(this.number);

  // String toString() {
  //   return ("$number $numberString");
  // }

  static List<ExampleNumber> get list {
    return (map.keys.map((num) {
      return (ExampleNumber(num));
    })).toList();
  }
}

class Searching extends StatefulWidget {
  static final navKey = GlobalKey<NavigatorState>();
  static String routeName = "/search";

  const Searching({Key navKey}) : super(key: navKey);

  @override
  _SearchingState createState() => _SearchingState();
}

class _SearchingState extends State<Searching> {
  //bool asTabs = false;
  String selectedValueCategoryDialog;

  // String? selectedValueSingleDialogDarkMode;
  List<DropdownMenuItem> items = [];
  List<DropdownMenuItem> editableItems = [];
  final _formKey = GlobalKey<FormState>();
  String inputString = "";
  TextFormField input;
  List<DropdownMenuItem<ExampleNumber>> numberItems =
  ExampleNumber.list.map((exNum) {
    return (DropdownMenuItem(child: Text(exNum.numberString), value: exNum));
  }).toList();


  static const String appTitle = "Search ";
  final String loremIpsum =
      "food  others  ,  clean,  make-up. medenice,";
  // SearchCategoryBloc searchCategoryBloc;

  @override
  void initState() {
    // searchCategoryBloc = SearchCategoryBloc(
    //     searchCategoryWebServices: SearchCategoryWebServices());
    String wordPair = "";
    loremIpsum
        .toLowerCase()
        .replaceAll(",", "")
        .replaceAll(".", "")
        .split(" ")
        .forEach((word) {
      if (wordPair.isEmpty) {
        wordPair = word + " ";
      } else {
        wordPair += word;
        if (items.indexWhere((item) {
          return (item.value == wordPair);
        }) ==
            -1) {
          items.add(DropdownMenuItem(
            child: Text(wordPair),
            value: wordPair,
          ));
        }
        wordPair = "";
      }
    });
    input = TextFormField(
      validator: (value) {
        return ((value?.length ?? 0) < 6
            ? "must be at least 6 characters long"
            : null);
      },
      initialValue: inputString,
      onChanged: (value) {
        inputString = value;
      },
      autofocus: true,
    );
    super.initState();
  }
  SearchingBloc searchingBloc;
  SearchModel searchModel;

  @override
  Widget build(BuildContext context) {
    Map<String, Widget> widgets;
    widgets = {

      "Category": SearchChoices.single(
        items: items,
        value: selectedValueCategoryDialog,
        hint: "Select one",
        searchHint: "Select one",
        onChanged: (value) {
          setState(() {
            selectedValueCategoryDialog = value;
          });
        },
        isExpanded: true,
      ),
      "Search": Text(''),
    };
     return BlocProvider<SearchingBloc>(
      create: (context) => searchingBloc,
      child: BlocConsumer<SearchingBloc, SearchingStates>(
           listener: (contetxt, state) {
             if (state is SearchingSuccessState) {
              showToast(text: 'success', state: ToastStates.SUCCESS);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Products()));
          }
           }, builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios_outlined),
            ),
            title: const Text(appTitle),

          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: widgets
                  .map((k, v) {
                return (MapEntry(
                    k,
                    Center(
                        child: k != "Search"
                            ? Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            margin: EdgeInsets.all(20),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: <Widget>[
                                  Text("$k:"),
                                  v,
                                ],
                              ),
                            ))
                            : Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                             BlocBuilder<SearchingBloc,
                                SearchingStates>(
                               builder: (context, state) {
                                 if (state is SearchingLoadingState) return const CircularProgressIndicator();
                                 return  Container(
                                 decoration: ThemeHelper()
                                     .buttonBoxDecoration(context),
    child: ElevatedButton(
    style: ThemeHelper().buttonStyle(),
    child: Padding(
    padding: EdgeInsets.fromLTRB(
    40, 10, 40, 10),
    child: Text(
    'SEARCHING',
    style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white),
    ),
    ),
    onPressed: () {
    print(k);
    // if (_formKey.currentState
    //     .validate()) {}

   searchingBloc.searchingFun(name: selectedValueCategoryDialog.replaceAll(' ', ''));
    }),
    );}
                                 //Button(
                                   //  press: () {
                            //           print('nameccccategory=${  selectedValueCategoryDialog!.replaceAll(' ', '')}');
                            //           searchCategoryBloc
                            //               .searchCategoryname(
                            //               name_category:
                            //               selectedValueCategoryDialog!
                            //                   .replaceAll(
                            //                   ' ',
                            //                   ''));
                            //         },
                            //
                            //         text: "Search",
                            //         width: 150,
                            //         borderRadius: 18,
                            //         isUpperCase: false,
                            //         backColor:
                            //         const Color(0xFFF17532));
                            //   },
                            // ),

                        )
    ]))
                                 ));
              })
                  .values
                  .toList()
                ..add(
                  const Center(
                    child: SizedBox(
                      height: 500,
                    ),
                  ),
                ), //prevents scrolling issues at the end of the list of Widgets
            ),
          ),
        );}
      )
     );         }
  }
      //}),
    //);


*/







