import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_final/Screens/Login_Screen.dart';
import 'package:firebase_final/Screens/Post_Screen.dart';
import 'package:firebase_final/Screens/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> keyy = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignUp In Screen'),
      ),
      body: Form(
        key: keyy,
        child: Container(
          child: Column(
            children: [
              TextFormField(
                validator: RequiredValidator(errorText: '*Reauired'),
                controller: nameController,
                decoration: InputDecoration(labelText: 'Enter your Name'),
              ),
              SizedBox.square(),
              TextFormField(
                validator: RequiredValidator(errorText: '*Reauired'),
                controller: emailController,
                decoration: InputDecoration(labelText: 'Enter your Email'),
              ),
              SizedBox.square(),
              TextFormField(
                validator: RequiredValidator(errorText: '*Reauired'),
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Enter your Email'),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (keyy.currentState!.validate()) {
                      auth.createUserWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text).then((value) => {
                      Navigator.of(context).pop()

                      });
                    }
                  },
                  child: Text('Sign Up')),
            ],
          ),
        ),
      ),
    );
  }
}
