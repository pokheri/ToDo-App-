import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/repository/task_api.dart';

class CreateTaskPage extends StatefulWidget {
  final int? taskId; // optional taskId for update
  final String? title; // optional title for update
  final String? description; // optional description for update

  CreateTaskPage({super.key, this.title, this.description, this.taskId});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String currentDate = DateFormat('d MMM h:mm a').format(DateTime.now());
  bool valuePresent = true;

  @override
  void initState() {
    super.initState();
    // Assign controllers if task is being updated
    titleController.text = widget.title ?? '';
    descriptionController.text = widget.description ?? '';
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                if (valuePresent) {
                  bool success;

                  if (widget.taskId != null) {
                    // Update task
                    success = await TaskApi.updateTask(
                      titleController.text,
                      descriptionController.text,
                      '${widget.taskId}',
                    );
                  } else {
                    // Create new task
                    success = await TaskApi.createnewTask(
                      titleController.text,
                      descriptionController.text,
                    );
                  }

                  if (success) {
                    Navigator.pop(context);
                  }
                }
              }
            },
            label: Text('Done'),
            icon: Icon(Icons.done, size: 27),
          ),
        ],
        actionsPadding: EdgeInsets.only(right: 22),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 0, left: 22, right: 22),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.only(top: 9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: titleController,
                    onSaved: (newValue) {
                      // already using controller, so optional
                    },
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                    decoration: _inputDecoration("Title"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, top: 4),
                    child: Text(
                      currentDate,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.w200),
                    ),
                  ),
                  TextFormField(
                    controller: descriptionController,
                    validator: (value) {
                      if ((titleController.text.isEmpty) && ((value ?? "").isEmpty)) {
                        valuePresent = false;
                      } else {
                        valuePresent = true;
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      // already using controller, so optional
                    },
                    maxLines: 20,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                    decoration: _inputDecoration("Description"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

OutlineInputBorder _outlineInputBorder() {
  return OutlineInputBorder(borderRadius: BorderRadius.zero, borderSide: BorderSide.none);
}

InputDecoration _inputDecoration(String hintText) {
  return InputDecoration(
    contentPadding: EdgeInsets.zero,
    hintText: hintText,
    errorBorder: _outlineInputBorder(),
    enabledBorder: _outlineInputBorder(),
    disabledBorder: _outlineInputBorder(),
    focusedBorder: _outlineInputBorder(),
  );
}
