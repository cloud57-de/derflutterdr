import 'package:derflutterdr/todo.dart';
import 'package:flutter/material.dart';
import 'package:derflutterdr/todos.dart';

class DeleteDialog {
  Todo todo;
  DeleteDialog({this.todo});
  void showDeletionDialog(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Yes"),
      onPressed:  () {
          Navigator.of(context).pop(); // Dialog
          Navigator.pop(context); // Screen
          todos.del(this.todo);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Delete"),
      content: Text("Do you really want to delete this todo?"),
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
