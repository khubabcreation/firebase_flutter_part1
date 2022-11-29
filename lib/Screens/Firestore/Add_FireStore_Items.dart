import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_final/Screens/Firestore/FireStoreScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddFireStoreItems extends StatefulWidget {
  const AddFireStoreItems({Key? key}) : super(key: key);

  @override
  State<AddFireStoreItems> createState() => _AddFireStoreItemsState();
}

class _AddFireStoreItemsState extends State<AddFireStoreItems> {
  final txtController = TextEditingController();
   final ref = FirebaseFirestore.instance.collection('Look');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add items in FireStore'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            controller: txtController,
            decoration: InputDecoration(labelText: 'Enter the items here'),
          ),
          ElevatedButton(onPressed: () {
            String id = DateTime.now().millisecond.toString();
            ref.doc(id).set({
              'Name':txtController.text.toString(),
              'id':id
            });
            Navigator.push(context, MaterialPageRoute(builder: (context) => FireStoreScreen(),));
          }, child: Text('Add items'))
        ],
      ),
    );
  }
}
