import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task_model.dart';
import '../provider/todo_provider.dart';
import 'add_todo.dart';
import 'dart:core';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
  }

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await addDataWidget(context,
              TaskModel(title: '', description: '', id: '', terminated: false));
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(
          'TODO List',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<TaskModel>>(
        future: context.read<TodoProvider>().fetchData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('Empty'),
            );
          }
          if (snapshot.data!.isEmpty) {
            return Center(
              child: Text('Empty'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }

          List<TaskModel> tasks = snapshot.data!;
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (_, index) {

              return Container(
                margin: EdgeInsets.fromLTRB(8,15,8,0),

                child: Material(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: Colors.white,
                  elevation: 10,
                  shadowColor: Colors.black,
                  child: ListTile(
                    leading: Checkbox(
                      activeColor: Colors.grey,
                      checkColor: Colors.white,
                      value: tasks[index].terminated,
                      onChanged: (bool? value) {
                        Provider.of<TodoProvider>(context, listen: false)
                            .updateTerminated(tasks[index].id, {
                          "name": tasks[index].title,
                          "description": tasks[index].description,
                          "terminated": value,
                        }).whenComplete(() {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Task terminated')));
                        });
                        setState(() {
                          tasks[index].terminated = value!;
                          print(tasks[index].terminated);
                        });
                      },
                    ),
                    title: Text(
                      tasks[index].title,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          decoration: tasks[index].terminated
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color:
                              tasks[index].terminated ? Colors.grey : Colors.black),
                    ),
                    subtitle: Text(
                      tasks[index].description,
                      style: TextStyle(
                          color:
                              tasks[index].terminated ? Colors.grey : Colors.black),
                    ),
                    trailing: FittedBox(
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                context
                                    .read<TodoProvider>()
                                    .deleteData(tasks[index].id);
                                setState(() {});
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Task deleted')));
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              )),
                          IconButton(
                              onPressed: () async {
                                await addDataWidget(context, tasks[index]);
                                setState(() {});
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Task edited')));
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.orange,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
