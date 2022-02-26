import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';

enum UserStatus {
  none,
  error,
  success,
  waiting,
  email,
}

@freezed
class Todo with _$Todo {
  const factory Todo({
    @Default('') String description,
    @Default('') String id,
    @Default(false) bool completed,
  }) = _Todo;
  
  const Todo._();
}
