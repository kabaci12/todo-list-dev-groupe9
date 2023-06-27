import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos_project/database.dart';
import 'package:todos_project/model/todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    on<TodoEvent>((event, emit) async {
      if (event is TodoInitialize) {
        emit(TodoLoading());
        try {
          final todos = await DatabaseServices.instance.getTodos();
          emit(TodoLoaded(todos: todos));
        } catch (e) {
          emit(TodoError());
        }
      }
      if (event is TodoAdded) {
        if (state is TodoLoaded) {
          final todos = (state as TodoLoaded).todos;
          emit(TodoLoading());
          final uid = await DatabaseServices.instance.createTodo(event.todo);
          final todo = event.todo.copyWith(uid: uid);
          todos.add(todo);
          emit(TodoLoaded(todos: todos));
        }
      }

      if (event is TodoUpdated) {
        final todos = (state as TodoLoaded)
            .todos
            .map((e) => (e.uid == event.todo.uid ? event.todo : e))
            .toList();
        await DatabaseServices.instance.updateTodo(event.todo);
        emit(TodoLoaded(todos: todos));
      }

      if (event is TodoRemoved) {
        final todos = (state as TodoLoaded).todos;
        todos.remove(event.todo);
        emit(TodoLoading());
        await DatabaseServices.instance.removeTodo(event.todo);
        emit(TodoLoaded(todos: todos));
      }
    });
  }
}
