import 'package:bloc_auth/blocs/todo_bloc/todo_bloc.dart';
import 'package:bloc_auth/screen/agora/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../user_repository/model/todo/todo_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  addTodo(Todo todo) {
    context.read<TodoBloc>().add(
          AddTodo(todo),
        );
  }

  removeTodo(Todo todo) {
    context.read<TodoBloc>().add(RemoveTodo(todo));
  }

  alterTodo(int index) {
    context.read<TodoBloc>().add(
          AlterToDo(index),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'My TODO',
          style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
          if (state.status == TodoStatus.success) {
            return ListView.builder(
                itemCount: state.todos.length,
                itemBuilder: (context, int i) {
                  return Card(
                    color: Theme.of(context).colorScheme.primary,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Slidable(
                      key: const ValueKey(0),
                      startActionPane: ActionPane(motion: const ScrollMotion(), children: [
                        SlidableAction(onPressed: (_){
                          removeTodo(state.todos[i]);
                        },
                          backgroundColor: const Color(0xFFFF0000),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        )
                      ]),
                      child: ListTile(
                        title: Text(state.todos[i].title),
                        subtitle: Text(state.todos[i].subtitle),
                        trailing: Checkbox(value: state.todos[i].isDone,
                            activeColor: Theme.of(context).colorScheme.secondary,
                            onChanged: (value){
                          alterTodo(i);

                        }),
                      ),
                    ),
                  );
                });
          } else if (state.status == TodoStatus.initial) {
            return const Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  Text('Please Wait your data is Loading')
                ],
              ),
            );
          } else {
            return Container();
          }
        }),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80),
        child: Row(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      TextEditingController taskController = TextEditingController();
                      TextEditingController taskController2 = TextEditingController();
                      return AlertDialog(
                        title: const Text('Add task'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: taskController,
                              cursorColor: Theme.of(context).colorScheme.secondary,
                              decoration: InputDecoration(
                                  hintText: 'Task Title',
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          const BorderSide(color: Colors.grey))),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: taskController2,
                              cursorColor: Theme.of(context).colorScheme.secondary,
                              decoration: InputDecoration(
                                  hintText: 'Task Description',
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          const BorderSide(color: Colors.grey))),
                            ),
                          ],
                        ),
                        actions: [
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: TextButton(
                                onPressed: () {
                                  addTodo(Todo(
                                      title: taskController.text,
                                      subtitle: taskController2.text));
                                  taskController.text = '';
                                  taskController2.text = '';
                                  Navigator.pop(context);
                                },
                                style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color:
                                            Theme.of(context).colorScheme.secondary,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    foregroundColor:
                                        Theme.of(context).colorScheme.secondary),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: const Icon(
                                    CupertinoIcons.check_mark,
                                    color: Colors.green,
                                  ),
                                )),
                          )
                        ],
                      );
                    });
              },
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
            FloatingActionButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const IndexPage()));

            },
            child: const Icon(Icons.broadcast_on_home),)
          ],
        ),
      ),
    );
  }
}
