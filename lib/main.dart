import 'package:derflutterdr/backend.dart';
import 'package:derflutterdr/scr_todos.dart';
import 'package:derflutterdr/scr_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:derflutterdr/glbs.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return MaterialApp(
      title: glbs.appTitle,
      home: !backendService.isSignedIn()? ScrLogin(): ScrTodos(),
    );
  }
}
