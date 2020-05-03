import 'package:derflutterdr/backend.dart';
import 'package:derflutterdr/todo.dart';

class Todos {

  Future<void> add(String todotext) async {
    await backendService.addTodo(todotext);
  }

  Future<void> del(Todo todo) async {
    await backendService.delTodo(todo.id);
  }

  Future<void> set(Todo todo) async {
    await backendService.setTodo(todo);
  }

  Future<void> toggleCompleted(Todo todo) async {
    await backendService.toggleCompletedTodo(todo);
  }

}

final Todos todos = Todos();
