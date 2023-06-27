import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_project/bloc/todo_bloc.dart';
import 'package:todos_project/model/todo.dart';

void modalSheet({
  required BuildContext context,
  Todo? todo,
}) {
  TextEditingController title = TextEditingController(
    text: todo != null ? todo.title : "",
  );
  TextEditingController description = TextEditingController(
    text: todo != null ? todo.description : "",
  );
  showModalBottomSheet(
    context: context,
    builder: (bc) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Créer une Tache",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            TextFormField(
              controller: title,
              decoration: const InputDecoration(hintText: "Titre"),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: description,
              decoration: const InputDecoration(hintText: "Description"),
              maxLines: null,
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                if (title.text.isEmpty || description.text.isEmpty) {
                  // TODO : Smooth msg
                } else {
                  final todo1 = Todo(
                    title: title.text,
                    description: description.text,
                    uid: todo?.uid,
                    completed: todo == null ? false : todo.completed,
                  );
                  BlocProvider.of<TodoBloc>(context).add(
                    (todo == null)
                        ? TodoAdded(todo: todo1)
                        : TodoUpdated(todo: todo1),
                  );
                  Navigator.pop(bc);
                }
              },
              child: Container(
                height: 45,
                width: double.infinity,
                color: Colors.blue,
                child: const Center(
                  child: Text(
                    "Enregistrer",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}
