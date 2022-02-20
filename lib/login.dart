import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:provider/provider.dart';  
//import 'src/authentication.dart'; 
//import 'src/widgets.dart';  

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _Login();
}

class _Login extends State<LoginPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  bool _loading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _loading ? Loading() : Center(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(controller: email,
            validator: (String? text) {
              if (text == null || text.isEmpty)
                return "You can't leave this field blank!";
              else if (!text.contains('@'))
                return "That is not a valid email address!";
              return null;
            }),
            
            TextFormField(controller: password,
            validator: (String? text) {
              if (text == null || text.length < 8)
                return "Your password must be at least 8 characters!";
              return null;
            }),

            ElevatedButton(onPressed: () {}, child: const Text("Log In"),),
            ElevatedButton(onPressed: () {}, child: const Text("Register"),),
            ElevatedButton(onPressed: () {}, child: const Text("Sign in with Google"),),

          ],
        )
      )
    ));
  }

  void login(BuildContext context) async {
    if(_formKey.currentState!.validate()) {
      try {
        await auth.signInWithEmailAndPassword(email: email.text, password: password.text);
      } on FirebaseAuthException catch(e) {
        if(e.code == "wrong-email" || e.code == "wrong-password")
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Incorrect login information!!!")));
      } catch(e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }
}

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
  
}