import 'package:flutter/foundation.dart';

///クラスの定義の仕方
///finalはなぜ必要？：
//requiredは必要？：どのみち引数を渡すので合った方がよい
//({})と()だけの違い：()→引数を渡すときに、id: のようにでない。({})→出るのでオススメ
@immutable
class Todo {
  const Todo(
      {required this.id, required this.description, required this.isCompleted});
  final int id;
  final String description;
  final bool isCompleted;

  Todo copyWith({int? id, String? description, bool? isCompleted}) {
    return Todo(
      id: id ?? this.id,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
