import 'package:flutter_riverpod/flutter_riverpod.dart';

import './todo.dart';
import './todo_api.dart';

class TodoNotifier extends StateNotifier<List<Todo>> {
  final todoApi = TodoApi();
  TodoNotifier() : super([]);

  _initialize() async {
    state = await todoApi.findAll();
  }

  addTodo(String name) async {
    Todo t = await todoApi.create(name);
    state = [...state, t];
  }

  delete(Todo todo) async {
    await todoApi.delete(todo.id);
    state.remove(todo);
    state = [...state];
  }

  updateCompleted(Todo todo) async {
    // do something here
  }
}

final todoProvider = StateNotifierProvider<TodoNotifier, List<Todo>>((ref) {
  final tn = TodoNotifier();
  tn._initialize();
  return tn;
});
