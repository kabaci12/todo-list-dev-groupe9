import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:todos_project/bloc/todo_bloc.dart';
import 'package:todos_project/presentation/screen/detail.dart';
import 'package:todos_project/presentation/widget/modal_bottom_sheet.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Todo Group 9",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          modalSheet(context: context);
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is TodoLoaded) {
            state.todos.sort((a, b) => b.uid!.compareTo(a.uid!));

            return MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final todo = state.todos[index];
                return GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) {
                    //       return Detail(todo: todo);
                    //     },
                    //   ),
                    // );
                  },
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (bc) {
                        return CupertinoAlertDialog(
                          title: const Text("Que voulez-vous faire ?"),
                          content: const Text(
                              "Veuillez choisir ce que vous voulez faire"),
                          actions: [
                            CupertinoDialogAction(
                              child: const Text("Modifier"),
                              onPressed: () {
                                Navigator.pop(bc);
                                modalSheet(context: context, todo: todo);
                              },
                            ),
                            CupertinoDialogAction(
                              child: const Text("Supprimer"),
                              onPressed: () {
                                Navigator.pop(bc);
                                BlocProvider.of<TodoBloc>(context).add(
                                  TodoRemoved(todo: todo),
                                );
                              },
                            ),
                            CupertinoDialogAction(
                              child: const Text("Annuler"),
                              onPressed: () => Navigator.pop(bc),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 200,
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: (todo.completed)
                          ? Colors.green[300]
                          : Colors.yellow[100],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          todo.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          todo.description,
                          maxLines: 1,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          height: 25,
                          child: Row(
                            children: [
                              FlutterSwitch(
                                value: todo.completed,
                                height: 25,
                                width: 45,
                                activeColor: Colors.green,
                                onToggle: (value) {
                                  BlocProvider.of<TodoBloc>(context).add(
                                    TodoUpdated(
                                      todo: todo.copyWith(completed: value),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(width: 5),
                              Text((todo.completed) ? "Completed" : "Waiting")
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
