import 'package:flutter/material.dart';
import 'widgets/list_item.dart';
import 'widgets/my_app.dart';

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
