import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Add_FireStore_Items.dart';

class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({Key? key}) : super(key: key);

  @override
  State<FireStoreScreen> createState() => _FireStoreScreenState();
}

class _FireStoreScreenState extends State<FireStoreScreen> {
  final ref = FirebaseFirestore.instance.collection('Look').snapshots();
  final fire = FirebaseFirestore.instance.collection('Look');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fire Store Screen'),
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: ref,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Something Went wrong');
              } else
                return Expanded(
                    child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) => ListTile(
                        onTap: (){
                          String id = snapshot.data!.docs[index]['id'].toString();
                          fire.doc(id).update({'Name':'My name is khan'});
                          
                        },
                            title: Text(
                                snapshot.data!.docs[index]['Name'].toString()),
                          )),
                ));
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddFireStoreItems(),
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
