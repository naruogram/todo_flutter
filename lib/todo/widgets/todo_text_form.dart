import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_flutter/todo/Provider/todo_page_provider.dart';

class TodoTextForm extends HookConsumerWidget {
  const TodoTextForm({
    Key? key,
    required this.formKey,
    required this.controller,
    this.hintText,
    this.textInputType = TextInputType.text,
    this.maxLength = 50,
  }) : super(key: key);

  final GlobalKey<FormFieldState<String>> formKey;
  final TextEditingController controller;
  final String? hintText;
  final TextInputType textInputType;
  final int maxLength;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TextFormField(
        key: formKey,
        keyboardType: textInputType,
        maxLength: maxLength,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText ?? '',
        ),
        onFieldSubmitted: (value) {
          ref.read(todoListProvider.notifier).add(value);
          controller.clear();
        },
      )
    ]);
  }
}
