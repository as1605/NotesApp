import 'package:flutter/material.dart';

void main() {
  runApp(NotesApp());
}

class DrawingItem {
  int id = 0;
  String title = "New Drawing";

  DrawingItem(this.id, this.title);
}

class NotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NotesApp',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DashBoard(title: 'NotesApp'),
    );
  }
}

class DashBoard extends StatefulWidget {
  DashBoard({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DashBoardState createState() => _DashBoardState();
}

List<ListTile> getWidgetsList(List<DrawingItem> listItems) {
  List<ListTile> widgets = [];
  for (int i = 0; i < listItems.length; i++) {
    widgets.add(ListTile(
      title: Text(listItems[i].title),
    ));
  }
  return widgets;
}

class _DashBoardState extends State<DashBoard> {
  List<DrawingItem> listItems = [
    DrawingItem(1, "Drawing A"),
    DrawingItem(2, "Drawing B"),
    DrawingItem(3, "Drawing C"),
    DrawingItem(3, "Drawing C"),
    DrawingItem(3, "Drawing C"),
    DrawingItem(3, "Drawing C"),
    DrawingItem(3, "Drawing C"),
    DrawingItem(3, "Drawing C"),
    DrawingItem(3, "Drawing C"),
    DrawingItem(3, "Drawing C"),
    DrawingItem(3, "Drawing C"),
    DrawingItem(3, "Drawing C"),
    DrawingItem(3, "Drawing C"),
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
        onPressed: () => {print("button pressed")},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
