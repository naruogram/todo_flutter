import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_flutter/todo/domain/models/todo.dart';
import 'package:todo_flutter/todo/domain/todo_repository.dart';


enum TodoListFilter {
  all,
  active,
  completed,
}

final todoListProvider = StateNotifierProvider<TodoRepository, List<Todo>>((ref) {
  return TodoRepository(const []);
});

final todoListFilter = StateProvider((_) => TodoListFilter.all);

final currentTodo = Provider<Todo>((ref) => throw UnimplementedError());

final uncompletedTodosCount = Provider<int>((ref) {
  return ref.watch(todoListProvider).where((todo) => !todo.completed).length;
});

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
 class TodoListPageController extends ChangeNotifier {
  TodoListPageController(this.ref) : super();
  final Ref ref;
  
}
