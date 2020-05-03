import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:derflutterdr/todo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class BackendService {

  /*

  Auth ------------------------------------------------------------------------

   */

  FirebaseAuth _auth = FirebaseAuth.instance;

  GoogleSignIn _googleSignIn = GoogleSignIn();

  Firestore _db = Firestore.instance;
  Firestore getDb(){
    return _db;
  }

  FirebaseUser _user;
  FirebaseUser getUser(){
    return _user;
  }

  bool _isSignedIn = false;
  bool isSignedIn(){
    return _isSignedIn;
  }

  Future<FirebaseUser> googleSignIn() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    this._user = (await _auth.signInWithCredential(credential)).user;
    _isSignedIn = true;
    return this._user;
  }

  Future<void> signOut() async {
    await _auth.signOut()
    .then( (_) {
      _isSignedIn = false;
    })
    .catchError( (e) => print(e.toString()) );
  }

  /*

  Database --------------------------------------------------------------------

   */

  Stream getTodosStream(){
    return backendService.getDb()
        .collection('users')
        .document(backendService.getUser().email)
        .collection('todos')
        .snapshots();
  }

  Future<void> addTodo(String todotext) async {
    DocumentReference ref = _db.collection('users')
        .document(this._user.email)
        .collection('todos')
        .document();
    var map = {
      'todo': todotext,
      'completed': false,
      'id': ref.documentID
    };
    ref.setData(map);
  }

  Future<void> delTodo(String id) async {
    await _db.collection('users')
        .document(this._user.email)
        .collection('todos')
        .document(id)
        .delete();
  }

  Future<void> toggleCompletedTodo(Todo td) async {
    var newcomp = !td.completed;
    await _db.collection('users')
        .document(this._user.email)
        .collection('todos')
        .document(td.id)
        .setData({
          'id':td.id,
          'todo':td.text,
          'completed':newcomp
        });
  }

  Future<void> setTodo(Todo td) async {
    await _db.collection('users')
        .document(this._user.email)
        .collection('todos')
        .document(td.id)
        .setData({
          'id':td.id,
          'todo':td.text,
          'completed':td.completed
        });
  }

}

final BackendService backendService = BackendService();
