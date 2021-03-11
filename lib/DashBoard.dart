import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Draw.dart';

Future<void> writeTitle(int id, String s) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('title' + id.toString(), s);
}

Future<String> readTitle(int id) async {
  String out;
  final prefs = await SharedPreferences.getInstance();
  out = prefs.getString('title' + id.toString());
  return out;
}

Future<void> writePoints(int id, List<Offset> L) async {
  String temp = "";
  L.forEach((element) {
    if (element != null)
      temp += '(' + element.dx.toString() + ',' + element.dy.toString() + ')';
  });
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('points' + id.toString(), temp);
}

Future<List<Offset>> readPoints(int id) async {
  List<Offset> out = <Offset>[];
  String temp;
  final prefs = await SharedPreferences.getInstance();
  temp = prefs.getString('points' + id.toString());
  if (temp == null) return out;
  String x = "", y = "";
  int i = 0;
  while (i < temp.length) {
    if (temp[i] == '(') {
      i++;
      while (temp[i] != ',') {
        x += temp[i];
        i++;
      }
      i++;
      while (temp[i] != ')') {
        y += temp[i];
        i++;
      }
      i++;
    }
    out.add(Offset(double.parse(x), double.parse(y)));
    x = "";
    y = "";
  }
  return out;
}

class DrawingItem {
  final int id;
  String title = "New Note";
  List<Offset> points = <Offset>[];

  DrawingItem(this.id);
}

class DashBoard extends StatefulWidget {
  DashBoard({Key key}) : super(key: key);

  final String title = "NotesApp";

  @override
  _DashBoardState createState() => _DashBoardState();
}

int N = 0;
List<DrawingItem> listItems = [];

class _DashBoardState extends State<DashBoard> {
  TextEditingController textController = TextEditingController();

  void addNewItemToList(int id) async {
    DrawingItem T = DrawingItem(id);
    String t = await readTitle(id);
    if (t == null) {
      writeTitle(T.id, T.title);
    } else
      T.title = t;
    setState(() {
      listItems.add(T);
    });
    if (readTitle(id) != null) {
      T.title = await readTitle(id);
    }
  }

  List<ElevatedButton> getWidgetsList(List<DrawingItem> listItems, context) {
    List<ElevatedButton> widgets = [];
    listItems.forEach((element) {
      widgets.add(ElevatedButton(
          onPressed: () async {
            //for testing, update when clicked
            String t = await readTitle(element.id);
            List<Offset> p = await readPoints(element.id);
            setState(() {
              element.title = t;
              element.points = p;
            });
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Draw(element)),
            );
          },
          child: Text(element.title),
          style: ElevatedButton.styleFrom(
            primary: Colors.red.shade800,
            elevation: 10,
            side: BorderSide(color: Colors.red.shade900, width: 5),
          )));
    });
    return widgets;
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
        onPressed: () => {addNewItemToList(++N)},
        child: Icon(Icons.add),
      ),
    );
  }
}
