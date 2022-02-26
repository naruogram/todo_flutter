import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_flutter/todo/Provider/todo_page_provider.dart';

class Toolbar extends HookConsumerWidget {
  const Toolbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(todoListFilter);

    Color? textColorFor(TodoListFilter value) {
      return filter == value ? Colors.blue : Colors.black;
    }

    return Material(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              //完了していないタスクを監視して数を数えている
              '${ref.watch(uncompletedTodosCount).toString()}個のタスク',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Tooltip(
            key: allTodoKey,
            message: '全て',
            child: TextButton(
              onPressed: () =>
              //enumで定義したものを参照してフィルターをかける
                  ref.read(todoListFilter.notifier).state = TodoListFilter.all,
              style: ButtonStyle(
                visualDensity: VisualDensity.compact,
                foregroundColor:
                    MaterialStateProperty.all(textColorFor(TodoListFilter.all)),
              ),
              child: const Text('全て'),
            ),
          ),
          Tooltip(
            key: activeTodoKey,
            message: 'アクティブ',
            child: TextButton(
              onPressed: () => ref.read(todoListFilter.notifier).state =
                  TodoListFilter.active,
              style: ButtonStyle(
                visualDensity: VisualDensity.compact,
                foregroundColor: MaterialStateProperty.all(
                  textColorFor(TodoListFilter.active),
                ),
              ),
              child: const Text('挑戦中'),
            ),
          ),
          Tooltip(
            key: completedTodoKey,
            message: '達成',
            child: TextButton(
              onPressed: () => ref.read(todoListFilter.notifier).state =
                  TodoListFilter.completed,
              style: ButtonStyle(
                visualDensity: VisualDensity.compact,
                foregroundColor: MaterialStateProperty.all(
                  textColorFor(TodoListFilter.completed),
                ),
              ),
              child: const Text('達成'),
            ),
          ),
        ],
      ),
    );
  }
}