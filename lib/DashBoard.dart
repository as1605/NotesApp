import 'package:flutter/material.dart';
import 'Info.dart';

class DrawingItem {
  final int id;
  final String title;

  DrawingItem(this.id, this.title);
}

class DashBoard extends StatefulWidget {
  DashBoard({Key key}) : super(key: key);

  final String title = "NotesApp";

  @override
  _DashBoardState createState() => _DashBoardState();
}

List<ElevatedButton> getWidgetsList(List<DrawingItem> listItems) {
  List<ElevatedButton> widgets = [];
  for (int i = 0; i < listItems.length; i++) {
    widgets.add(ElevatedButton(
        onPressed: () => {print("Pressed")},
        child: Text(listItems[i].title),
        style: ElevatedButton.styleFrom(
          primary: Colors.red.shade900,
        )));
  }
  return widgets;
}

class _DashBoardState extends State<DashBoard> {
  List<DrawingItem> listItems = [
    DrawingItem(1, "Drawing A"),
    DrawingItem(2, "Drawing B"),
    DrawingItem(3, "Drawing C"),
  ];
  TextEditingController textController = TextEditingController();

  void addNewItemToList(int id, String title) {
    setState(() => {listItems.add(DrawingItem(id, title))});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
              TextField(
                controller: textController,
              )
            ] +
            getWidgetsList(listItems),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Info()),
          )
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
