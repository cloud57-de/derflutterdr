import 'package:derflutterdr/scr_todo.dart';
import 'package:derflutterdr/todo.dart';
import 'package:derflutterdr/todos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:derflutterdr/dialog_delete.dart';

class TodoCard extends StatelessWidget {
  Todo todo;
  TodoCard({this.todo});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            //MaterialPageRoute(builder: (context) => ScrTodo(this.currentTodo,this.deleteCallback,this.toggleCompletedCallback)),
            MaterialPageRoute(builder: (context) => ScrTodo(todo: this.todo)),
          );
        },
        child: Container(
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  children:<Widget>[
                    todo.completed ?
                    IconButton(
                        icon: Icon(Icons.check_box),
                        onPressed: () {
                          //this.toggleCompletedCallback(this.currentTodo);
                          todos.toggleCompleted(this.todo);
                        },
                    )
                    :
                    IconButton(
                        icon: Icon(Icons.check_box_outline_blank),
                        onPressed: (){
                          //this.toggleCompletedCallback(this.currentTodo);
                          todos.toggleCompleted(this.todo);
                        }
                    ),
                    IconButton(
                      onPressed: (){
                        DeleteDialog(todo: this.todo).showDeletionDialog(context);
                      },
                        icon: Icon(Icons.delete)
                    ),
                    Text("")
                  ]
                ),
                Flexible(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(""),
                        Text("ID:" + this.todo.id, style: TextStyle(color:Colors.lightBlue)),
                        Text(this.todo.text),
                        Text("")
                      ]
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}
