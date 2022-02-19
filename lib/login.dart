import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';  
import 'src/authentication.dart'; 
import 'src/widgets.dart';  

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  
  @override
  State<LoginPage> createState() => _Login();
  }

}

class _Login extends State<LoginPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  _formKey = GlobalKey<FormState>();
  email = TextEditingController();
  password = TextEditingController();

  bool _loading = false;
  @override

  @override
  Widget build(BuildContext context) {
    return _loading ? Loading() : Center(
      child: Form(
        key: _form,
        child: Column(
          children: [
            TextFormField(controller: email,
            validator: (String? text) {
              return null;
            }),
            
            TextFormField(controller: password,
            validator: (String? text) {
              if (text == null || text.length < 8)
                return "Your password must be at least 8 characters!";
            }),

            ElevatedButton(onPressed: onPressed, child: const Text("Log In"),),
            ElevatedButton(onPressed: onPressed, child: const Text("Register"),),
            ElevatedButton(onPressed: onPressed, child: const Text("Sign in with Google"),),

          ],
        )
      )
    );
  
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  
}