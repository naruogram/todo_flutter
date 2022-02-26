import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_flutter/todo/domain/models/todo.dart';
import 'package:todo_flutter/todo/domain/todo_repository.dart';

//enumは再定義できないようにするために使用?
enum TodoListFilter {
  all,
  active,
  completed,
}

//todoを管理するprovider　常に変化を見ている
final todoListProvider = StateNotifierProvider<TodoRepository, List<Todo>>((ref) {
  return TodoRepository(const []);
});

//全て
final todoListFilter = StateProvider((_) => TodoListFilter.all);

//よくわかっていないが動いている
final currentTodo = Provider<Todo>((ref) => throw UnimplementedError());

//完了していないタスクのカウント
final uncompletedTodosCount = Provider<int>((ref) {
  return ref.watch(todoListProvider).where((todo) => !todo.completed).length;
});

//フィルターをかける
final filteredTodos = Provider<List<Todo>>((ref) {
  final filter = ref.watch(todoListFilter);
  final todos = ref.watch(todoListProvider);

  switch (filter) {
    case TodoListFilter.completed:
      return todos.where((todo) => todo.completed).toList();
    case TodoListFilter.active:
      return todos.where((todo) => !todo.completed).toList();
    case TodoListFilter.all:
      return todos;
  }
});

final addTodoKey = GlobalKey<FormFieldState<String>>();
final activeTodoKey = UniqueKey();
final completedTodoKey = UniqueKey();
final allTodoKey = UniqueKey();
