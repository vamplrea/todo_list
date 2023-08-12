import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/models/todo.dart';

final todoProvider = StateNotifierProvider<TodoListNotifier, List<Todo>>((ref) {
  return TodoListNotifier(initialTodos: [
    Todo(todoId: 0, content: "This is a 1st thing todo", completed: false),
    Todo(todoId: 1, content: "This is a 2nd thing todo", completed: false),
    Todo(todoId: 2, content: "This is a 3rd thing todo done", completed: true),
  ]);
});

class TodoListNotifier extends StateNotifier<List<Todo>> {
  //TodoListNotifier() : super([]);
  TodoListNotifier({required List<Todo> initialTodos}) : super(initialTodos);
  void addTodo(String content) {
    state = [
      ...state,
      Todo(
          todoId: state.isEmpty ? 0 : state[state.length - 1].todoId + 1,
          content: content,
          completed: false)
    ];
  }

  void completeTodo(int id) {
    state = [
      for (final todo in state)
        if (todo.todoId == id)
          Todo(
            todoId: todo.todoId,
            content: todo.content,
            completed: true,
          )
        else
          todo
    ];
  }

  void deleteTodo(int id) {
    state = state.where((todo) => todo.todoId != id).toList();
  }
}
