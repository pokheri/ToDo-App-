import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  String currentDate = DateFormat('d MMM h:mm a').format(DateTime.now());

  final _formKey = GlobalKey<FormState>();
  String? title;
  String? description;
  bool valuePresent = true;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                if (valuePresent) {
                  // send the api call other wise just pop up
                } else {}
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
                      title = newValue;
                    },
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                    decoration: _inputDecoration("Title"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      currentDate,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.w200),
                    ),
                  ),
                  TextFormField(
                    controller: descriptionController,
                    validator: (value) {
                      if (titleController.text.isEmpty && (value ?? " ").isEmpty) {
                        valuePresent = false;
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      description = newValue;
                    },
                    maxLines: 100,
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
