import 'package:flutter/foundation.dart';

///クラスの定義の仕方
///①finalはなぜ必要？
///②requiredは必要？
///③({})と()だけの違い
@immutable
class Todo {
  const Todo(
      {required this.id, required this.description, this.isCompleted = false});
  final String id;
  final String description;
  final bool isCompleted;

  @override
  String toString() {
    return "Todo(description: $description, isCompleted: $isCompleted)";
  }
}
