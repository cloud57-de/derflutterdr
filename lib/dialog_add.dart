import 'package:derflutterdr/todos.dart';
import 'package:flutter/material.dart';

class AddDialog {
  var addCont;
  AddDialog() {
    addCont = TextEditingController();
  }
  @override
  void dispose() {
    addCont.dispose();
  }
  void showAddDialog(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () => Navigator.of(context).pop()
    );
    Widget continueButton = FlatButton(
      child: Text("Add"),
      onPressed:  () => todos.add(addCont.text).then( (_) => Navigator.of(context).pop() )
    );
    AlertDialog alert = AlertDialog(
      title: Text("Add new todo"),
      content: Container(
        width: 160,
        child: TextField(
          maxLines: 8,
          maxLength: 1024,
          keyboardType: TextInputType.multiline,
          controller: addCont,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Enter todo here...',
          ),
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}