import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hat_draw_app/hdw_classes/tiles/category_tile.dart';
import 'package:hat_draw_app/hdw_classes/draw_button.dart';
import 'package:hat_draw_app/pages/categories_page.dart';
import 'package:hat_draw_app/pages/draw_page.dart';
import 'package:hat_draw_app/pages/items_page.dart';
import 'package:hat_draw_app/pages/init_page.dart';
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hat Draw',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        '/init' : (context) => InitPage(),
        '/categories': (context) => CategoriesPage(),
        '/items': (context) => ItemsPage(),
        '/draw': (context) => DrawPage(),
      },
      home: InitPage(), //const MyHomePage(title: 'Hat Draw'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
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


