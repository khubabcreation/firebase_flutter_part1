import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_final/Screens/Login_Screen.dart';
import 'package:firebase_final/Screens/Post_Add_items_Screen.dart';
import 'package:firebase_final/Screens/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Post');
  final searchController = TextEditingController();
  final editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut().then((value) => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    )));
              },
              icon: Icon(Icons.logout))
        ],
        title: Text('Post Screen'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                  labelText: 'Search',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black))),
              onChanged: (String value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: (context, snapshot, animation, index) {
                  final title = snapshot.child('Name').value.toString();
                  final id = snapshot.child('id').value.toString();
                  if (searchController.text.isEmpty) {
                    return ListTile(
                      leading: Text(index.toString()),
                      title: Text(snapshot.child('Name').value.toString()),
                      trailing: PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                              value: 1,
                              child: ListTile(
                                onTap: () {
                                  Navigator.pop(context);
                                  showMyDialog(title, id);
                                },
                                leading: Icon(Icons.edit),
                                title: Text('Edit'),
                              )),
                          PopupMenuItem(
                              child: ListTile(
                            onTap: () {
                              ref.child(id).remove();
                              Navigator.of(context).pop();
                            },
                            leading: Icon(Icons.delete),
                            title: Text('Delete'),
                          )),
                        ],
                        icon: Icon(Icons.more_vert),
                      ),
                    );
                  } else if (title
                      .toLowerCase()
                      .contains(searchController.text.toLowerCase())) {
                    return ListTile(
                      leading: Text(index.toString()),
                      title: Text(snapshot.child('Name').value.toString()),
                    );
                  } else {
                    return Container(
                      color: Colors.red,
                    );
                  }
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostAddItemsScreen(),
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> showMyDialog(String title, String id) async {
    editController.text = title;
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update'),
        content: Container(
          child: TextField(
            controller: editController,
            decoration: InputDecoration(hintText: 'Edit here'),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                ref.child(id).update({'Name': editController.text}).then(
                    (value) => Navigator.pop(context));
              },
              child: Text('Edit')),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'))
        ],
      ),
    );
  }
}
