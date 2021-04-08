import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_and_firebasee/HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget{
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors

          if (snapshot.hasError) {
            debugPrint(snapshot.error.toString());
            return ErrorPage();
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            debugPrint('Masuk');
            return new MaterialApp(
                home: Home()
            );
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return Loading();
        }
    );
  }
}
