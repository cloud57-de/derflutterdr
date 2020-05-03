import 'package:derflutterdr/scr_todos.dart';
import 'package:flutter/material.dart';
import 'package:derflutterdr/backend.dart';
import 'package:derflutterdr/glbs.dart';

enum states {
  loading,
  login,
  waitforgoogle,
  ready
}

class ScrLogin extends StatefulWidget {
  @override
  _ScrLoginState createState() {
    return _ScrLoginState();
  }
}

class _ScrLoginState extends State<ScrLogin> {

  var _state = states.login;

  Widget build(BuildContext context){
    if(backendService.isSignedIn()){
      setState(() {
        _state = states.ready;
      });
    }
    switch (_state) {
      case states.loading:
        return widgetLoading();
      case states.login:
        return widgetLogin();
      case states.waitforgoogle:
        backendService.googleSignIn()
        .then( (_) => setState( () => _state = states.ready ) )
        .catchError( (e) => setState( () => _state = states.login ) );
        return widgetLoading();
      case states.ready:
        return ScrTodos();
    }
  }

  Widget widgetLoading(){
    return Scaffold(
        appBar: AppBar(
          title: Text(glbs.appTitle),
        ),
        body: Center(
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
        )
    );
  }


  Widget widgetLogin(){
    return Scaffold(
        appBar: AppBar(
          title: Text(glbs.appTitle),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                      children: <Widget>[
                        Text("You are logged out!\n"),
                        FlatButton(
                          onPressed: () {
                            setState(() {
                              _state = states.waitforgoogle;
                            });
                          },
                          color: Colors.blue,
                          child: Text(
                              "Login with Google"
                          ),
                        ),
                      ]
                  ),
                ]
            )
        )
    );
  }
}
