import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_subject3/constants.dart';
import 'package:flutter_subject3/todo.dart';

final todoListProvider = StateNotifierProvider<TodoListNotifier, List<Todo>>(
    (ref) => TodoListNotifier());

class TodoListNotifier extends StateNotifier<List<Todo>> {
  //ViewModelのコンストラクタがよく分からない：
  //①左側の()と右側の()の違い
  TodoListNotifier() : super(todoList);

  void add(Todo newTodo) {
    final List<Todo> newState = [];
    for (final todo in state) {
      newState.add(todo);
    }
    newState.add(newTodo);
    state = newState;
  }

  void setText(String text) {
    state = [];
  }

  void toggle(int id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            id: todo.id,
            description: todo.description,
            isCompleted: !todo.isCompleted,
          )
        else
          todo,
    ];
  }

  void edit({required int id, required String description}) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            id: todo.id,
            description: description,
            isCompleted: todo.isCompleted,
          )
        else
          todo,
    ];
  }

  void delete(Todo target) {
    state = state.where((todo) => todo.id != target.id).toList();
  }

  void reOrder(int oldIndex, int newIndex, Todo target) {
    //選択中のTodoを特定?
    final todo = state.where((todo) => todo.id != target.id);

    //空配列にすべてのTodoを格納し、操作できるようにする
    final List<Todo> newState = [];
    for (final todo in state) {
      newState.add(todo);
    }

    //
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final newTodo = newState.removeAt(oldIndex);
    newState.insert(newIndex, newTodo);
    state = newState;
  }

  // void updateTask(int id, String newTitle, bool newCompleted) {
  //   final index = state.indexWhere((task) => task.id == id);
  //   if (index != -1) {
  //     // 指定されたIDに一致するタスクのプロパティを更新する
  //     state = [
  //       ...state.sublist(0, index),
  //       state[index]
  //           .copyWith(id: id, description: newTitle, isCompleted: newCompleted),
  //       ...state.sublist(index + 1),
  //     ];
  //   }
  // }
}
