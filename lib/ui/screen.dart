import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasks/plugins/path_provider.dart';
import 'package:tasks/ui/widgets/tasklist.dart';

class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  List _myList = [];
  final _textfieldController = TextEditingController();
  // ignore: unused_field
  String? _name;

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
        Navigator.of(context).pop();
      });
    }
  }

  void _create(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            reverse: true,
            child: AlertDialog(
                clipBehavior: Clip.hardEdge,
                contentPadding: const EdgeInsets.fromLTRB(24.0, 1.0, 1.0, 1.0),
                scrollable: true,
                content: Stack(
                  children: <Widget>[
                    Form(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                1.0, 40.0, 30.0, 20.0),
                            child: TextFormField(
                                controller: _textfieldController,
                                onEditingComplete: _addTask,
                                autofocus: true,
                                decoration: const InputDecoration(
                                    labelText: 'New task'),
                                onChanged: (name) {
                                  _name = name;
                                }),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      top: 5.0,
                      right: 5.0,
                      child: FloatingActionButton(
                        hoverElevation: 0.1,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.close,
                            color: Color.fromRGBO(87, 87, 103, 1)),
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Color.fromRGBO(235, 235, 235, 1),
                                width: 1),
                            borderRadius: BorderRadius.circular(80)),
                        backgroundColor: const Color.fromRGBO(242, 243, 255, 1),
                        mini: true,
                        elevation: 0.1,
                      ),
                    ),
                  ],
                )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(64.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                const Text(
                  'Tasks',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 56,
                  ),
                ),
                const Spacer(),
                OutlinedButton(
                  onPressed: () => _create(context),
                  child: Image.asset("assets/add_icon.png"),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(242, 243, 255, 1),
                    fixedSize: const Size(56, 56),
                    primary: const Color.fromRGBO(235, 235, 235, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    side: const BorderSide(
                        width: 1, color: Color.fromRGBO(235, 235, 235, 1)),
                  ),
                )
              ],
            ),
            const Padding(
                padding: EdgeInsets.only(top: 32, bottom: 32),
                child: Divider(height: 1)),
            TaskList(_myList),
          ],
        ),
      ),
    );
  }
}
