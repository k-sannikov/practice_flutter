import 'package:cloud_firestore/cloud_firestore.dart';

class TaskManager {

  static void addTask(String userId, String task) async {
    FirebaseFirestore.instance.collection('tasks').add({
      'userId': userId,
      'task': task,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  static void deleteTask(String id) {
    FirebaseFirestore.instance.collection('tasks').doc(id).delete();
  }

}
