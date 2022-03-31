import 'package:flutter/material.dart';
import 'package:tasks/plugins/path_provider.dart';

class TaskList extends StatefulWidget {
  final List _myList;

  const TaskList(this._myList, {Key? key}) : super(key: key);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  late Map<String, dynamic> _lastRemoved;
  late int _lastPosRemoved;

  @override
  Widget build(BuildContext context) {
    var _myList = widget._myList;

    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
          setState(() {
            _myList.sort((a, b) {
              if (a["done"] && !b["done"]) {
                return 1;
              } else if (!a["done"] && b["done"]) {
                return -1;
              } else {
                return 0;
              }
            });
            PathProvider.saveData(_myList);
          });
        },
        child: ListView.builder(
          itemCount: _myList.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: UniqueKey(),
              background: Container(
                color: Colors.red,
                child: const Align(
                  alignment: Alignment(-0.9, 0.0),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
              direction: DismissDirection.startToEnd,
              child: SwitchListTile(
                activeThumbImage: const NetworkImage(
                    'https://lists.gnu.org/archive/html/emacs-devel/2015-10/pngR9b4lzUy39.png'),
                title: Text(_myList[index]["title"]), // текст
                value: _myList[index]["done"],
                activeColor: Colors.red,
                secondary: CircleAvatar(
                  foregroundColor: const Color.fromRGBO(87, 87, 103, 1),
                  backgroundColor: const Color.fromRGBO(252, 252, 252, 1),
                  child:
                      Icon(_myList[index]["done"] ? Icons.check : Icons.close),
                ),
                onChanged: (c) {
                  setState(() {
                    _myList[index]["done"] = c;
                    PathProvider.saveData(_myList);
                  });
                },
              ),
              onDismissed: (direction) {
                setState(() {
                  _lastRemoved = Map.from(widget._myList[index]);
                  _lastPosRemoved = index;
                  widget._myList.removeAt(index);

                  PathProvider.saveData(_myList);
                  final snack = SnackBar(
                    content: Text("Task ${_lastRemoved["title"]} removed!"),
                    action: SnackBarAction(
                      label: "Undo",
                      onPressed: () {
                        setState(() {
                          widget._myList.insert(_lastPosRemoved, _lastRemoved);
                          PathProvider.saveData(_myList);
                        });
                      },
                    ),
                    duration: const Duration(seconds: 3),
                  );
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(snack);
                });
              },
            );
          },
        ),
      ),
    );
  }
}


/* //sdfsdf


bool selected = true;

//...

Widget build(BuildContext context) {
	return Scaffold(
    	body: Center(
          child: IconButton(
              icon: Icon( selected ? Icons.celebration : Icons.title),
              onPressed: () {
                setState(() {
                  selected = !selected;
                });
              },
          ), //IconButton
   		), //Center
    ); //Scaffold
} */