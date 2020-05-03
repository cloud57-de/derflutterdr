import 'dart:async';
import 'package:flutter/material.dart';

import 'glbs.dart';

class ScrAbout extends StatefulWidget {
  @override
  _ScrAboutState createState() {
    return _ScrAboutState();
  }
}

class _ScrAboutState extends State<ScrAbout> {

  Timer timer;

  var text = [
    "" + glbs.appTitle, // Title
    "Version " + glbs.appVersion + " (" + glbs.appDate + ")", // Version + Date
    "" + glbs.appOrigin, // URL
  ];
  var _ptr = 0;
  void inc() {
    setState(() {
      _ptr++;
      if( _ptr >= text.length ){
        _ptr = 0;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic( Duration(seconds: 2), (Timer t) => inc() );
  }
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                Text(
                  text[_ptr],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      height: 1,
                      fontSize: 24
                  ),
                ),
                Text(""),
                CircularProgressIndicator(
                  backgroundColor: Colors.red,
                )
              ]
            )
        )
    );
  }

}
