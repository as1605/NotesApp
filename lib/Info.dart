import 'package:flutter/material.dart';
import 'package:notesapp/DashBoard.dart';

class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Info")),
      body: Text("InfoBody"),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DashBoard()),
          )
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
