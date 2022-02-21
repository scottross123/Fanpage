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

class MakePost extends StatefulWidget {
  const MakePost({Key? key}) : super(key: key);
  
  State<MakePost> createState() => _MakePost();
}

class _MakePost extends State<MakePost> {
  final _formKey = GlobalKey<FormState>();
  final msg = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      body: Center( 
            child: Form(
              key: _formKey,
              child: Column(
                children: [ 
                  TextFormField(
                    controller: msg,
                    validator: (String? text) {
                      if (text == null || text.isEmpty)
                        return "You can't leave this field blank!";
                      return null;
                    },

                    decoration: InputDecoration(
                      hintText: "Message",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ],
              )
            )
          )
        );
  } 
}