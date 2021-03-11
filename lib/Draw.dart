import 'package:flutter/material.dart';
import 'DashBoard.dart';

class Draw extends StatefulWidget {
  final DrawingItem D;
  Draw(this.D);
  @override
  _DrawState createState() => new _DrawState(D);
}

class _DrawState extends State<Draw> {
  DrawingItem D;
  _DrawState(this.D);
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
                    writeTitle(D.id, value);
                    setState(() {
                      D.title = value;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              _rename(D, context);
            }),
        title: Text(D.title),
      ),
      body: Container(
        child: GestureDetector(
          onPanUpdate: (DragUpdateDetails details) => {
            setState(() {
              RenderBox object = context.findRenderObject();
              D.points = List.from(D.points)
                ..add(object.globalToLocal(details.localPosition));
            })
          },
          onPanEnd: (DragEndDetails details) => D.points.add(null),
          child: CustomPaint(
            painter: Sketcher(points: D.points),
            size: Size.infinite,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          writePoints(D.id, D.points);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DashBoard()),
          );
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
      ..strokeWidth = 1.0;
    if (points == null) return;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(Sketcher oldDelegate) => oldDelegate.points != points;
}
