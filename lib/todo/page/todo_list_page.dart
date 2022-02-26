import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:todo_flutter/todo/Provider/todo_page_provider.dart';
import 'package:todo_flutter/todo/model/todo_model.dart';
import 'package:todo_flutter/todo/widgets/todo_text_form.dart';
import 'package:todo_flutter/todo/widgets/title_todo.dart';
import 'package:todo_flutter/todo/widgets/tool_bar.dart';

class TodoListPage extends HookConsumerWidget {
  const TodoListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(filteredTodos);
    TextEditingController todoController=TextEditingController();
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            body: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                children: [
              const BasicTitle(),
              TodoTextForm(
                formKey: addTodoKey,
                controller: todoController,
                hintText: "目標を追加してください",
              ),
              const SizedBox(height: 42),
              const Toolbar(),
              if (todos.isNotEmpty) const Divider(height: 0),
              for (var i = 0; i < todos.length; i++) ...[
                if (i > 0) const Divider(height: 0),
                Dismissible(
                  key: ValueKey(todos[i].id),
                  onDismissed: (_) {
                    ref.read(todoListProvider.notifier).remove(todos[i]);
                  },
                  child: ProviderScope(
                    overrides: [
                      _currentTodo.overrideWithValue(todos[i]),
                    ],
                    child: const TodoItem(),
                  ),
                )
              ]
            ])));
  }
}

final _currentTodo = Provider<Todo>((ref) => throw UnimplementedError());

class TodoItem extends HookConsumerWidget {
  const TodoItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todo = ref.watch(_currentTodo);
    final itemFocusNode = useFocusNode();
    useListenable(itemFocusNode);
    final isFocused = itemFocusNode.hasFocus;
    final textEditingController = useTextEditingController();
    final textFieldFocusNode = useFocusNode();

    return Material(
      color: Colors.white,
      elevation: 6,
      child: Focus(
        focusNode: itemFocusNode,
        onFocusChange: (focused) {
          if (focused) {
            textEditingController.text = todo.description;
          } else {
            ref
                .read(todoListProvider.notifier)
                .edit(id: todo.id, description: textEditingController.text);
          }
        },
        child: ListTile(
          onTap: () {
            itemFocusNode.requestFocus();
            textFieldFocusNode.requestFocus();
          },
          leading: Checkbox(
            value: todo.completed,
            onChanged: (value) =>
                ref.read(todoListProvider.notifier).toggle(todo.id),
          ),
          title: isFocused
              ? TextField(
                  autofocus: true,
                  focusNode: textFieldFocusNode,
                  controller: textEditingController,
                )
              : Text(todo.description),
        ),
      ),
    );
  }
}
