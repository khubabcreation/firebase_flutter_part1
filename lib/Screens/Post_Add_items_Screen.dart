import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostAddItemsScreen extends StatefulWidget {
  const PostAddItemsScreen({Key? key}) : super(key: key);

  @override
  State<PostAddItemsScreen> createState() => _PostAddItemsScreenState();
}

class _PostAddItemsScreenState extends State<PostAddItemsScreen> {
  TextEditingController postController = TextEditingController();
  final dbref = FirebaseDatabase.instance.ref('Post');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Add items Screen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: postController,
            maxLines: 4,
            decoration: InputDecoration(
                labelText: 'Add items',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black))),
          ),
          ElevatedButton(
              onPressed: () {
                String id = DateTime.now().millisecond.toString();

                dbref
                    .child(id)
                    .set({'Name': postController.text.toString(), 'id': id});
                Navigator.pop(context);
              },
              child: Text('Add items'))
        ],
      ),
    );
  }
}
