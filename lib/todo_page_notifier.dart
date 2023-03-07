import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_subject3/todo.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

final todoListProvider = StateNotifierProvider((ref) => TodoList());

class TodoList extends StateNotifier<List<Todo>> {
  ///ViewModelのコンストラクタがよく分からない
  ///①左側の()と右側の()の違い
  TodoList([List<Todo>? initialTodos]) : super(initialTodos ?? []);

  void add(String description) {
    state = [...state, Todo(id: _uuid.v4(), description: description)];
  }

  void toggle(String id) {
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

  void edit({required String id, required String description}) {
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
}
