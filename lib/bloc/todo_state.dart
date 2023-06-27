// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();
  
  @override
  List<Object> get props => [];
}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {
  
}
class TodoLoaded extends TodoState {
  final List<Todo> todos ;
  const TodoLoaded({
    required this.todos
  });

   @override
  List<Object> get props => [todos];
}
class TodoError extends TodoState {
  
}