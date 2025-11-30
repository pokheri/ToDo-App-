import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/repository/task_api.dart';
import 'package:todo/routes/routes_name.dart';
import 'package:todo/screens/create_task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<dynamic>>? tasksFuture;

  @override
  void initState() {
    super.initState();
    tasksFuture = TaskApi.getMyTasks();
  }

  // Call this to reload tasks after delete
  void reloadTasks() {
    setState(() {
      tasksFuture = TaskApi.getMyTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.createTask).then((_) {
            // reload tasks after returning from CreateTaskPage
            reloadTasks();
          });
        },
        child: Image.asset('assets/icons/edit.png', height: 21),
      ),
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icons/all.png', height: 26),
            SizedBox(width: 37),
            Image.asset('assets/icons/check.png', height: 26),
          ],
        ),
        actions: [Icon(Icons.settings, size: 26)],
        actionsPadding: EdgeInsets.only(right: 23),
        centerTitle: true,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: tasksFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final tasks = snapshot.data!;
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListItemClass(
                  title: task['title'],
                  description: task['description'],
                  taskId: task['id'],
                  onDeleted: reloadTasks, // pass parent callback
                );
              },
            );
          }
          return const Center(child: Text("No tasks found."));
        },
      ),
    );
  }
}

class ListItemClass extends StatefulWidget {
  final String title;
  final String description;
  final int taskId;
  final VoidCallback? onDeleted; // callback to notify parent

  const ListItemClass({
    super.key,
    required this.title,
    required this.description,
    required this.taskId,
    this.onDeleted,
  });

  @override
  State<ListItemClass> createState() => _ListItemClassState();
}

class _ListItemClassState extends State<ListItemClass> {
  bool isDeleting = false; // show loading indicator on delete

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateTaskPage(
                title: widget.title,
                description: widget.description,
                taskId: widget.taskId,
              ),
            ),
          ).then((_) {
            // Reload parent tasks after returning from CreateTaskPage
            widget.onDeleted?.call();
          });
        },
        tileColor: const Color.fromARGB(255, 213, 232, 240),
        splashColor: const Color(0xffF1EAFF),
        title: Text(
          widget.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.poppins(),
        ),
        subtitle: Text(widget.description, maxLines: 2, overflow: TextOverflow.ellipsis),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        trailing: isDeleting
            ? const SizedBox(
                width: 60,
                height: 30,
                child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
              )
            : TextButton.icon(
                onPressed: () async {
                  setState(() {
                    isDeleting = true;
                  });

                  final response = await TaskApi.deleteTask(widget.taskId.toString());

                  if (response) {
                    // Notify parent to reload the list
                    widget.onDeleted?.call();
                  } else {
                    print('Failed to delete the task');
                  }

                  setState(() {
                    isDeleting = false;
                  });
                },
                label: const Text("Delete"),
                icon: const Icon(Icons.delete),
              ),
      ),
    );
  }
}
