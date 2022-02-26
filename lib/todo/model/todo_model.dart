import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

@immutable
class Todo {
  const Todo({
    required this.description,
    required this.id,
    // required this.time,
    this.completed = false,
  });

  final String id;
  final String description;
  // final String time;
  final bool completed;

  @override
  String toString() {
    return 'Todo(description: $description, completed: $completed)';
  }
}

class TodoMethod extends StateNotifier<List<Todo>> {
  TodoMethod([List<Todo>? initialTodos]) : super(initialTodos ?? []);

  void add(String description){
    state = [
    ...state,
      Todo(
        id: _uuid.v4(),
        description: description,
      ),
    ];
  }
    void toggle(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            id: todo.id,
            completed: !todo.completed,
            description: todo.description,
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
            completed: todo.completed,
            description: description,
          )
        else
          todo,
    ];
  }

  void remove(Todo target) {
    state = state.where((todo) => todo.id != target.id).toList();
  }

}