import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter_and_firebasee/DetailPage.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Home> {
  //Top Post
  StreamSubscription<QuerySnapshot>subscription;
  List<DocumentSnapshot>snapshot;
  CollectionReference collectionReference=FirebaseFirestore.instance.collection("TopPost");

  //Body Post
  StreamSubscription<QuerySnapshot>sdSubscription;
  List<DocumentSnapshot>sdSnapshot;
  CollectionReference sdCollectionReference = FirebaseFirestore.instance.collection("BodyPost");

  @override
  void initState() {
    subscription = collectionReference.snapshots().listen((event) {
      setState(() {
        snapshot = event.docs;
      });
    });

    sdSubscription = sdCollectionReference.snapshots().listen((event) {
      setState(() {
        sdSnapshot = event.docs;
      });
    });
    super.initState();
  }

  passData(DocumentSnapshot snap){
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DetailPage(snapshot: snap,)));
  }
  
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

      body: ListView(
        children: [
          Container(
            height: 200,
            child: ListView.builder(
              itemCount: snapshot.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index ){
                return Card(
                  elevation: 10,
                    margin: EdgeInsets.all(5),

                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(snapshot[index].data()['url'],
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(snapshot[index].data()['title'],
                          style: TextStyle(fontSize: 19, color: Colors.purple),
                          ),
                        ],
                      ),
                    ),
                );
              },
            ),
          ),

          Container(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: sdSnapshot.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index){
                return Card(
                  elevation: 7,
                  margin: EdgeInsets.all(10),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              child: Text(sdSnapshot[index].data()["title"][0]),
                              backgroundColor: Colors.purple,
                              foregroundColor: Colors.white,
                            ),
                            SizedBox(width: 10,),
                            InkWell(
                              child: Text(sdSnapshot[index].data()["title"],
                                style: TextStyle(fontSize: 20, color: Colors.purple),
                              ),
                              onTap: (){
                                passData(sdSnapshot[index]);
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(sdSnapshot[index].data()["url"],
                              height: 150,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                            ),

                            SizedBox(height: 10,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.thumb_up, color: Colors.purple,),
                                Icon(Icons.share, color: Colors.green),
                                Icon(Icons.thumbs_up_down, color: Colors.yellow)
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }
            ),
          )
        ],
      ),

    );
  }
}

class Loading extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Text('Loading'),
    );
  }
}

class ErrorPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Text('Error'),
    );
  }
}

