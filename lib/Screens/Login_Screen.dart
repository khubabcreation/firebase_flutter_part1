import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_final/Screens/PhoneNumber_Screen.dart';
import 'package:firebase_final/Screens/Post_Screen.dart';
import 'package:firebase_final/Screens/SignUp_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final key = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        title: Text('Log In Screen'),
      ),
      body: Form(
        key: key,
        child: Column(
          children: [
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
                  if (key.currentState!.validate()) {
                    auth
                        .signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text)
                        .then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PostScreen(),
                          ));
                    });
                  }
                },
                child: Text('Log in')),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpScreen(),
                      ));
                },
                child: Text('Sign UP')),
            SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PhoneNumberScreen(),
                    ));
              },
              child: Container(
                height: 30,
                child: Text('Sign Up with Phone Number'),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black54)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
