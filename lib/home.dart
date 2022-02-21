import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanpage/database_service.dart';
import 'package:fanpage/login.dart';
import 'package:fanpage/user.dart';
import 'package:fanpage/user_list.dart';
import 'package:fanpage/database_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:provider/provider.dart';  
//import 'src/authentication.dart'; 
//import 'src/widgets.dart';
import 'package:fanpage/post.dart';     

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference posts = FirebaseFirestore.instance.collection("posts");


  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.currentUser);
    print(DatabaseService.userMap[auth.currentUser!.uid]!.role);
    return Scaffold(
      floatingActionButton: DatabaseService.userMap[auth.currentUser!.uid]!.role == "ADMIN" ? FloatingActionButton.extended(
        icon: const Icon(Icons.add), 
        label: const Text("ADMIN POST"),
        onPressed: () { addPost(context); },
      ) : null,
      
      body: StreamBuilder<QuerySnapshot> (
        stream: posts.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError)
            return const Text("Something went wrong querying users");

          if (snapshot.connectionState == ConnectionState.waiting)
            return const Center(child: CircularProgressIndicator());

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot doc) {
              var post = doc.data() as Map<String, dynamic>;
            return ListTile(
              title: Text(post["message"])
            );
          }).toList());
        },
      ),
      
   
    );
  } 

  void addPost(BuildContext) async {
    await db.collection("post").add(
      {
        "message": msg.text,
        "timestamp": DateTime.now().millisecondsSinceEpoch,
        "name": FirebaseAuth.instance.currentUser!.displayName,
        "userID": FirebaseAuth.instance.currentUser!.uid,
      }
    );
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const MakePost()));
  }
}

