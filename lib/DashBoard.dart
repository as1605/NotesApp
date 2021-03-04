import 'package:flutter/material.dart';
import 'Draw.dart';

class DrawingItem {
  final int id;
  String title;
  DrawingItem(this.id, this.title);
}

class DashBoard extends StatefulWidget {
  DashBoard({Key key}) : super(key: key);

  final String title = "NotesApp";

  @override
  _DashBoardState createState() => _DashBoardState();
}

List<ElevatedButton> getWidgetsList(List<DrawingItem> listItems, context) {
  List<ElevatedButton> widgets = [];
  for (int i = 0; i < listItems.length; i++) {
    widgets.add(ElevatedButton(
        onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Draw(listItems[i])),
              )
            },
        child: Text(listItems[i].title),
        style: ElevatedButton.styleFrom(
          primary: Colors.red.shade900,
        )));
  }
  return widgets;
}

class _DashBoardState extends State<DashBoard> {
  int N = 3;
  List<DrawingItem> listItems = [
    DrawingItem(1, "Note A"),
    DrawingItem(2, "Note B"),
    DrawingItem(3, "Note C"),
  ];
  TextEditingController textController = TextEditingController();

  void addNewItemToList(int id, String title) {
    setState(() => {listItems.add(DrawingItem(id, title))});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.notes),
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
              TextField(
                controller: textController,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: ' Search',
                ),
              )
            ] +
            getWidgetsList(listItems, context),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {addNewItemToList(++N, "New Note")},
        child: Icon(Icons.add),
      ),
    );
  }
}
