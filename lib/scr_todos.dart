import 'package:derflutterdr/backend.dart';
import 'package:derflutterdr/dialog_add.dart';
import 'package:derflutterdr/scr_about.dart';
import 'package:derflutterdr/scr_login.dart';
import 'package:derflutterdr/scr_logout.dart';
import 'package:derflutterdr/todo.dart';
import 'package:flutter/material.dart';
import 'package:derflutterdr/todocard.dart';
import 'package:derflutterdr/glbs.dart';

class ScrTodos extends StatefulWidget {
  @override
  _ScrTodosState createState() {
    return _ScrTodosState();
  }
}

class _ScrTodosState extends State<ScrTodos> {
  var showCompleted = false;

  Widget widgetLoading(){
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                  children: <Widget>[
                    new CircularProgressIndicator(
                      backgroundColor: Colors.red,
                    ),
                  ]
              ),
            ]
        )
    );
  }

  Widget build(BuildContext context){
      if (!backendService.isSignedIn()){
        return ScrLogin();
      } else {
        return Scaffold(
            appBar: AppBar(
                title: Text(glbs.appTitle),
                actions: <Widget>[
                  showCompleted ?
                  IconButton(
                    icon: Icon(Icons.check_box),
                    onPressed: () => setState( () => showCompleted=false ),
                  )
                  :
                  IconButton(
                    icon: Icon(Icons.check_box_outline_blank),
                    onPressed: () => setState( () => showCompleted=true ),
                  ),

                  PopupMenuButton<Widget>(
                    icon: Icon(Icons.menu),
                      onSelected: (Widget w) => Navigator.push(context, MaterialPageRoute(builder: (context) => w)),
                      itemBuilder: (BuildContext context) => <PopupMenuEntry<Widget>>[
                        PopupMenuItem<Widget>(value: ScrLogout(refreshCallback: () => setState((){})), child: Row(children:<Widget>[Icon(Icons.exit_to_app, color: Colors.black), Text(" Logout")])),
                        PopupMenuItem<Widget>(value: ScrAbout(), child: Row(children:<Widget>[Icon(Icons.info, color: Colors.black), Text(" About")]))
                    ]
                  )

                ]
            ),

            body: StreamBuilder(
                stream: backendService.getTodosStream(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return widgetLoading();
                  }
                  List tmpl = [];
                  snapshot.data.documents.forEach((e) {
                    if (showCompleted) {
                      if(e['completed']) tmpl.add( Todo(id: e['id'], text: e['todo'], completed: e['completed']) );
                    } else {
                      if(!e['completed']) tmpl.add( Todo(id: e['id'], text: e['todo'], completed: e['completed']) );
                    }
                  });
                  return
                    SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: tmpl.map( (t) => TodoCard(todo: t) ).toList()
                        )
                    );
                }),

            floatingActionButton: FloatingActionButton(
              onPressed: () {
                AddDialog().showAddDialog(context);
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.blue,
            ),

        );
      }// else
  } // build

}
