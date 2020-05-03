import 'package:derflutterdr/todo.dart';
import 'package:derflutterdr/todos.dart';
import 'package:flutter/material.dart';

class EditDialog {
  Todo todo;
  var editCont;
  var refreshCallback;
  EditDialog({this.todo,this.refreshCallback}){
    editCont = TextEditingController(text:this.todo.text);
  }
  @override
  void dispose() {
    editCont.dispose();
  }
  void showEditDialog(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () => Navigator.of(context).pop()
    );
    Widget continueButton = FlatButton(
      child: Text("Apply"),
      onPressed: () {
        this.todo.text = editCont.text;
        todos.set(this.todo);
        Navigator.of(context).pop();
        this.refreshCallback();
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Edit todo"),
      content: Container(
        width: 160,
        child: TextField(
          maxLines: 8,
          maxLength: 1024,
          keyboardType: TextInputType.multiline,
          controller: editCont,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Edit todo text here...',
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
