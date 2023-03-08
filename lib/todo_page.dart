import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TodoPage extends HookConsumerWidget {
  TodoPage({Key? key}) : super(key: key);

  final List<int> _items = List<int>.generate(50, (int index) => index);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);
    return Scaffold(
      appBar: AppBar(),
      body: ReorderableListView(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        children: <Widget>[
          for (int index = 0; index < _items.length; index += 1)
            ListTile(
              key: Key('$index'),
              tileColor: _items[index].isOdd ? oddItemColor : evenItemColor,
              title: Text('Item ${_items[index]}'),
            ),
        ],
        onReorder: (int oldIndex, int newIndex) {
          // setState(() {
          //   if (oldIndex < newIndex) {
          //     newIndex -= 1;
          //   }
          //   final int item = _items.removeAt(oldIndex);
          //   _items.insert(newIndex, item);
          // });
        },
      ),
    );
  }
}
