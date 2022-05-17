import 'dart:async';
import 'package:flutter/material.dart';
import 'models/album.dart';
import 'widgets/ListItem.dart';

void main() {
  runApp(MyApp(
    items: List<ListItem>.generate(
      100,
      (i) => i % 6 == 0
          ? HeadingItem('Heading $i')
          : MessageItem('Sender $i', 'Message body $i'),
    ),
  ));
}

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
          title: 'Flutter Demo Home Page',
          items: items,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.items})
      : super(key: key);

  final String title;
  final List<ListItem> items;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum(_counter);
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      futureAlbum = fetchAlbum(_counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: const TabBar(
            tabs: [Tab(icon: Icon(Icons.home)), Tab(icon: Icon(Icons.list))]),
        title: Text(widget.title),
      ),
      body: TabBarView(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Increment for next album title:',
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headline4,
                ),
                RichText(
                  text: const TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Title:',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                FutureBuilder<Album>(
                  future: futureAlbum,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(snapshot.data!.title);
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }

                    // By default, show a loading spinner.
                    return const CircularProgressIndicator();
                  },
                ),
              ],
            ),
          ),
          ListView.builder(
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              final item = widget.items[index];

              return ListTile(
                title: item.buildTitle(context),
                subtitle: item.buildSubtitle(context),
              );
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
