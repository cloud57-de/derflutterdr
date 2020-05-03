import 'package:flutter/material.dart';
import 'package:derflutterdr/backend.dart';

class ScrLogout extends StatefulWidget {
  var refreshCallback;
  ScrLogout({this.refreshCallback});
  @override
  _ScrLogoutState createState() {
    return _ScrLogoutState(refreshCallback: this.refreshCallback);
  }
}

class _ScrLogoutState extends State<ScrLogout> {
  var refreshCallback;
  _ScrLogoutState({this.refreshCallback});
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text('Logout'),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                      children: <Widget>[
                        Text("You are logged in!\n"),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)
                          ),
                          child: Image.network(backendService.getUser().photoUrl),
                        ),
                        Text(""),
                        Text(backendService.getUser().displayName),
                        Text(backendService.getUser().email),
                        Text(""),
                        FlatButton(
                          onPressed: () {
                            backendService.signOut().then( (_) {
                              Navigator.pop(context);
                              this.refreshCallback();
                            });
                          },
                          color: Colors.blue,
                          child: Text(
                              "Logout"
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
