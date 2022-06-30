import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:task_list/services/auth.dart';
import '../services/task_manager.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({Key? key}) : super(key: key);

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  String? _userTask;

  void _dialogOpen(User user) {
    showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Добавить задачу'),
            content: TextField(
              onChanged: (String value) {
                _userTask = value;
              },
              autofocus: true,
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    TaskManager.addTask(user.uid, _userTask!);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Добавить')
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {

    final User user = Provider.of<User?>(context)!;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Список задач'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: AuthService().logOut
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('tasks')
            .where('userId', isEqualTo: user.uid)
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData) {
            return const SizedBox.shrink();
          }
          var task = snapshot.requireData.docs;
          return ListView.builder(
              itemCount: task.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: Key(task[index].id),
                  child: Card(
                    child: ListTile(
                      title: Text(task[index].get('task')),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.deepOrange,
                        ),
                        onPressed: () =>
                            TaskManager.deleteTask(task[index].id),
                      ),
                    ),
                  ),
                  onDismissed: (direction) =>
                      TaskManager.deleteTask(task[index].id),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _dialogOpen(user),
        child: const Icon(Icons.add),
      ),
    );
  }
}