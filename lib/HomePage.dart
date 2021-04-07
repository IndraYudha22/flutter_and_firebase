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

      drawer: Drawer(
        child: ListView(
          children: [

            UserAccountsDrawerHeader(accountName: Text('Code'),
              accountEmail: Text('Email'),
              decoration: BoxDecoration(
                color: Colors.purple
              ),
            ),

            ListTile(
                title: Text('First Page'),
                leading: Icon(Icons.search, color: Colors.green),
            ),
            ListTile(
              title: Text('Second Page'),
              leading: Icon(Icons.add, color: Colors.purple),
            ),
            ListTile(
              title: Text('Third Page'),
              leading: Icon(Icons.cake, color: Colors.redAccent),
            ),
            Divider(
              height: 10,
              color: Colors.black,
            ),
            ListTile(
              title: Text('Close'),
              leading: Icon(Icons.close, color: Colors.red),
              onTap: (){
                Navigator.of(context).pop();
              },
            )

          ],
        ),
      ),
    );
  }
}
