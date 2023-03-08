import 'package:flutter/foundation.dart';

///クラスの定義の仕方
///finalはなぜ必要？：
//requiredは必要？：どのみち引数を渡すので合った方がよい
//({})と()だけの違い：()→引数を渡すときに、id: のようにでない。({})→出るのでオススメ
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
