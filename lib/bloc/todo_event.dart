// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class TodoInitialize extends TodoEvent {
}

class TodoAdded extends TodoEvent {
  final Todo todo;
 const TodoAdded({
    required this.todo,
  });
}
class TodoRemoved extends TodoEvent {
  final Todo todo;
 const TodoRemoved({
    required this.todo,
  });
}
class TodoUpdated extends TodoEvent {
  final Todo todo;
  const TodoUpdated({
    required this.todo,
  });
}
