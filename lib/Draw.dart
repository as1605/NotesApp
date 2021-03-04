import 'package:flutter/material.dart';
import 'package:notesapp/DashBoard.dart';

class Draw extends StatefulWidget {
  final DrawingItem D;
  Draw(this.D);
  @override
  _DrawState createState() => new _DrawState(D);
}

Future<void> _rename(DrawingItem D, BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Rename'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextField(
                controller: TextEditingController(),
                onSubmitted: (String value) async {
                  D.title = value;
                },
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () => {Navigator.of(context).pop()},
          ),
        ],
      );
    },
  );
}

class _DrawState extends State<Draw> {
  final DrawingItem D;
  _DrawState(this.D);

  RenderBox object;
  List<Offset> _points = <Offset>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context2) {
              return IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  _rename(D, context);
                },
              );
            },
          ),
          title: Text(D.title)),
      body: Container(
        child: GestureDetector(
          onPanUpdate: (DragUpdateDetails details) => {
            setState(() {
              RenderBox object = context.findRenderObject();
              Offset _localPosition =
                  object.globalToLocal(details.globalPosition);
              _points = List.from(_points)..add(_localPosition);
            })
          },
          onPanEnd: (DragEndDetails details) => _points.add(null),
          child: CustomPaint(
            painter: Sketcher(points: _points),
            size: Size.infinite,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DashBoard()),
          )
        },
        child: Icon(Icons.save),
      ),
    );
  }
}

class Sketcher extends CustomPainter {
  List<Offset> points;
  Sketcher({this.points});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(Sketcher oldDelegate) => oldDelegate.points != points;
}