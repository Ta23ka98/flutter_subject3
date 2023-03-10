import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_subject3/edit_state_provider.dart';
import 'package:flutter_subject3/todo_page_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'todo.dart';

class TodoPage extends HookConsumerWidget {
  TodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(todoListProvider);
    final notifier = ref.read(todoListProvider.notifier);
    final editModeState = ref.watch(editModeProvider);
    final controller = TextEditingController(text: "");

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("ToDoリスト"),
              IconButton(
                  onPressed: () {
                    ref.read(editModeProvider.notifier).state = !editModeState;
                  },
                  icon: editModeState
                      ? const Icon(Icons.check)
                      : const Icon(Icons.edit)),
            ],
          ),
        ),
        body: ReorderableListView.builder(
          header: editModeState
              ? null
              : Column(
                  key: const Key("index"),
                  children: [
                    ListTile(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              String description = "";
                              return AlertDialog(
                                title: const Text("タスクを編集"),
                                content: TextField(
                                  onChanged: (value) {
                                    description = value;
                                  },
                                  //controller: controller,
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("キャンセル")),
                                  TextButton(
                                      onPressed: () {
                                        notifier.add(Todo(
                                            id: DateTime.now()
                                                .millisecondsSinceEpoch,
                                            description: description,
                                            isCompleted: false));
                                        Navigator.pop(context);
                                      },
                                      child: const Text("OK")),
                                ],
                              );
                            });
                      },
                      leading: const Icon(Icons.add),
                      title: const Text("タスクを追加"),
                    ),
                    const Divider(),
                  ],
                ),
          footer: editModeState
              ? null
              : Column(
                  key: const Key("index"),
                  children: [
                    ListTile(
                      onTap: () {
                        print("object");
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text("タスクを編集"),
                                  content: TextField(
                                    onChanged: (value) {
                                      String description;
                                      description = value;
                                    },
                                    controller: controller,
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("キャンセル")),
                                    TextButton(
                                        onPressed: () {
                                          // notifier.add(
                                          //     Todo(
                                          //     id: DateTime.now().millisecondsSinceEpoch,
                                          //     //description: description,
                                          //     isCompleted: false)
                                          // );
                                        },
                                        child: const Text("OK")),
                                  ],
                                ));
                      },
                      leading: const Icon(Icons.add),
                      title: const Text("タスクを追加"),
                    ),
                    const Divider(),
                  ],
                ),
          itemBuilder: (BuildContext context, int index) {
            return Column(
              key: Key("$index"),
              children: [
                ListTile(
                  onTap: () {
                    notifier.toggle(state[index].id);
                  },
                  trailing: editModeState
                      ? IconButton(
                          onPressed: () {
                            notifier.delete(state[index]);
                          },
                          icon: const Icon(Icons.close, color: Colors.red))
                      : state[index].isCompleted
                          ? const Icon(Icons.check, color: Colors.green)
                          : null,
                  title: state[index].isCompleted
                      ? Text(
                          state[index].description,
                          style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey),
                        )
                      : Text(state[index].description),
                ),
                const Divider(),
              ],
            );
          },
          itemCount: state.length,
          onReorder: (int oldIndex, int newIndex) {
            notifier.reOrder(oldIndex, newIndex, state[oldIndex]);
          },
        ));
  }
}
