import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_final/Screens/Post_Screen.dart';
import 'package:firebase_final/Screens/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class VerifyScreen extends StatefulWidget {
  VerifyScreen({Key? key, required this.verificationId}) : super(key: key);
  String verificationId;

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  TextEditingController verifyController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('varify screen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            validator: RequiredValidator(errorText: '*Reauired'),
            controller: verifyController,
            decoration: InputDecoration(labelText: 'Enter 6 digit code here'),
          ),
          ElevatedButton(
              onPressed: () {
                final Credentals = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: verifyController.text.toString());
                try {
                  auth.signInWithCredential(Credentals);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PostScreen(),));

                } catch (e) {
                  utils().toastMessage(e.toString());
                }
              },
              child: Text('Check')),
        ],
      ),
    );
  }
}
