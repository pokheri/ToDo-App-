import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Image.asset('assets/icons/edit.png', height: 21),
      ),
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 37,
          children: [
            Image.asset('assets/icons/all.png', height: 26),
            Image.asset('assets/icons/check.png', height: 26),
          ],
        ),

        actions: [Icon(Icons.settings, size: 26)],
        actionsPadding: EdgeInsets.only(right: 23),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Column(children: [Text("hello")]),
          ),
        ),
      ),
    );
  }
}
