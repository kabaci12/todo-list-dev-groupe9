// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final int? uid;
  final String title;
  final String description;
  final bool completed;

  const Todo({
    this.uid,
    required this.title,
    required this.description,
    this.completed = false,
  });
  @override
  List<Object?> get props => [uid, title, description, completed];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'completed': completed,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      uid: map['uid'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      completed: map['completed'] == "1" ? true : false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) =>
      Todo.fromMap(json.decode(source) as Map<String, dynamic>);

  Todo copyWith({
    int? uid,
    String? title,
    String? description,
    bool? completed,
  }) {
    return Todo(
      uid: uid ?? this.uid,
      title: title ?? this.title,
      description: description ?? this.description,
      completed: completed ?? this.completed,
    );
  }
}
