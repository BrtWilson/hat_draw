import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hat_draw_app/hdw_classes/category_tile.dart';
import 'package:hat_draw_app/hdw_classes/draw_button.dart';
import 'package:hat_draw_app/pages/categories_page.dart';
import 'package:hat_draw_app/pages/draw_page.dart';
import 'package:hat_draw_app/pages/items_page.dart';
import 'hdw_state.dart';

void main() {
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => HdwState())
          ],
          child: MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hat Draw',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blueGrey,
      ),
      initialRoute: '/',
      routes: {
        '/categories': (context) => CategoriesPage(),
        '/items': (context) => ItemsPage(),
        '/draw': (context) => DrawPage(),
      },
      home: CategoriesPage(), //const MyHomePage(title: 'Hat Draw'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // List<String> _categories = [];
  // List<CategoryContents> _catMap = [];
  //
  // void _newCategory(String value) {
  //   List<String> newList = [];
  //   CategoryContents newCategory = CategoryContents(value, newList);
  //   _categories.add(value);
  //   _catMap.add(newCategory);
  // }
  //
  // void _newItem(String categ, String item) {
  //   int index = _categories.indexOf(categ);
  //   _catMap[index].addItem(item);
  // }

  void _rebuild() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      // _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      //body: TestSequence()
      body: CategoriesPage(),
    );
  }
}

class TestSequence extends StatelessWidget {
  final String _name = "Test Name";
  final List<String> _categories = ["Test 1", "Test 5"];

  TestSequence({super.key});

  Function setState = (List<String> categories, String target, bool isIncluded) {
    if (isIncluded) {
      categories.add(target);
    }
    else {
      categories.remove(target);
    }
    return isIncluded;
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategoryTile(name: _name,),
        CategoryTile(name: "Test Name 2", parentCat: "Nothing"),
        //HdwWideButton(buttontext: "Test button", ),
        DrawButton(items: _categories)
      ],
    );
  }
}


/*
default page = home_route
-> route_category_items (home but with title boxes)
    (
      scaffold
      (
        column
        (
          scrollable column
          (
            [list]
            List Item
            (
              name
              edit icon
              check box
            )
          )
          Draw Button()
        )
      )
    )
-> route hat_drawing
    (
      scaffold
      (
        column (
          fancy text
          hat image (card?)
          re-draw button (+ save to hist / row)
          return to selection button
        }
      )
    )

additional features:
-> route_settings
-> route_history_items
-> route_save_to_cats

 */


