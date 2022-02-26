import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:todo_flutter/todo/Provider/todo_page_provider.dart';
import 'package:todo_flutter/todo/domain/models/todo.dart';
import 'package:todo_flutter/todo/domain/todo_repository.dart';
import 'package:todo_flutter/todo/widgets/todo_item.dart';
import 'package:todo_flutter/todo/widgets/todo_text_form.dart';
import 'package:todo_flutter/todo/widgets/title_todo.dart';
import 'package:todo_flutter/todo/widgets/tool_bar.dart';

class TodoListPage extends HookConsumerWidget {
  const TodoListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //todosはフィルターしたtodoを常に監視して参照している
    final todos = ref.watch(filteredTodos);

    TextEditingController todoController = TextEditingController();
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            body: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
                children: [
              const TodoTitle(),
              const SizedBox(height: 50),
              TodoTextForm(
                formKey: addTodoKey,
                controller: todoController,
                hintText: "目標を追加してください",
              ),
              const SizedBox(height: 50),
              const Toolbar(),
              if (todos.isNotEmpty) const Divider(height: 0),
              for (var i = 0; i < todos.length; i++) ...[
                if (i > 0) const Divider(height: 0),
                Dismissible(
                  key: ValueKey(todos[i].id),
                  onDismissed: (_) {
                    //readは任意のタイミングに一回だけ読み込む?
                    ref.read(todoListProvider.notifier).remove(todos[i]);
                  },
                  child: ProviderScope(
                    overrides: [
                      //todoが削除されることを監視している?
                      currentTodo.overrideWithValue(todos[i]),
                    ],
                    child: const TodoItem(),
                  ),
                )
              ]
            ])));
  }
}