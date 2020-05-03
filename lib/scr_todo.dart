import 'package:derflutterdr/dialog_edit.dart';
import 'package:derflutterdr/todo.dart';
import 'package:derflutterdr/todos.dart';
import 'package:flutter/material.dart';
import 'package:derflutterdr/dialog_delete.dart';

class ScrTodo extends StatefulWidget {
  Todo todo;
  ScrTodo({this.todo});
  @override
  _ScrTodoState createState() {
    return _ScrTodoState(todo: this.todo);
  }
}

class _ScrTodoState extends State<ScrTodo> {
  Todo todo;
  _ScrTodoState({this.todo});
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Todo'),
        ),
        body: SingleChildScrollView(
            child: Container(
                padding: new EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text("ID:" + todo.id, style: TextStyle(color: Colors.lightBlue)),
                      Text(""),
                      Text(
                        todo.text,
                        textAlign: TextAlign.left,
                        style: TextStyle(height: 1, fontSize: 24),
                      ),
                      Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              todo.completed ?
                              IconButton(
                                icon: Icon(Icons.check_box),
                                onPressed: () {
                                  todos.toggleCompleted(this.todo);
                                  this.todo.completed = !this.todo.completed;
                                  setState((){});
                                },
                              )
                              :
                              IconButton(
                                  icon: Icon(Icons.check_box_outline_blank),
                                  onPressed: (){
                                    todos.toggleCompleted(this.todo);
                                    this.todo.completed = !this.todo.completed;
                                    setState((){});
                                  }
                              ),
                              IconButton(
                                  onPressed: (){
                                    DeleteDialog(todo: this.todo).showDeletionDialog(context);
                                  },
                                  icon: Icon(Icons.delete)
                              ),
                              IconButton(
                                  onPressed: (){
                                    EditDialog(todo: this.todo, refreshCallback: () => setState((){}) ).showEditDialog(context);
                                  },
                                  icon: Icon(Icons.edit)
                              ),
                            ],
                          )
                      ),
                    ]
                )
            )
        )
    );
  }
}
