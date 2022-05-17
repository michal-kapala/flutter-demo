import 'package:flutter/material.dart';
import 'list_item.dart';
import 'my_homepage.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.items}) : super(key: key);
  final List<ListItem> items;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.pink),
      home: DefaultTabController(
        length: 2,
        child: MyHomePage(
          title: 'Flutter Demo App',
          items: items,
        ),
      ),
    );
  }
}
