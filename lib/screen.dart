import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasks/plugins/path_provider.dart';
import 'package:tasks/widgets/tasklist.dart';

class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  List _myList = [];
  final _textfieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    PathProvider.readData().then((data) {
      setState(() {
        _myList = json.decode(data!);
      });
    });
  }

  void _addTask() {
    if (_textfieldController.text != "") {
      setState(() {
        Map<String, dynamic> newList = {};
        newList["title"] = _textfieldController.text;
        newList["done"] = false;
        _myList.add(newList);
        _textfieldController.text = "";
        PathProvider.saveData(_myList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task List"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _textfieldController,
                    decoration: const InputDecoration(
                      labelText: "New Task",
                    ),
                  ),
                ),
                ElevatedButton(
                  child: const Text("Add"),
                  onPressed: _addTask,
                ),
              ],
            ),
          ),
          TaskList(_myList),
        ],
      ),
    );
  }
}
