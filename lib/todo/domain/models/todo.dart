import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_flutter/todo/Provider/todo_page_provider.dart';

part 'todo.freezed.dart';

@freezed
class Todo with _$Todo {
    const Todo._();
  const factory Todo({
    @Default('') String description,
    @Default('') String id,
    @Default(false) bool completed,
  }) = _Todo;
 
}
