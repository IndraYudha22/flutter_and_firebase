import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Firebase Beckend App"),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: ()=> debugPrint('Search')),
          IconButton(icon: Icon(Icons.add), onPressed: ()=> debugPrint('Add'))
        ],
      ),
    );
  }
}
