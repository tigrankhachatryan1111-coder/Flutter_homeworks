import 'package:flutter/material.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/widgets/task_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Task> tasks = [];
  final TextEditingController controller = TextEditingController();

  void _addTask() {
    if (controller.text.trim().isNotEmpty) {
      setState(() {
        tasks.add(Task(title: controller.text.trim()));
        controller.clear();
      });
    }
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Առաջադրանքների ցանկ'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Գրեք նոր առաջադրանք',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addTask,
                  child: const Text('Ավելացնել'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: tasks.isEmpty
              ? const Center(
                  child: Text('Առաջադրանքներ չկան'),
                )
              : ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return TaskItem(
                      task: tasks[index],
                      onDelete: () => _deleteTask(index),
                    );
                  },
                ),
            ),
          ],
        ),
      ),
    );
  }
}