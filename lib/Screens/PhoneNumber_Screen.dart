import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_final/Screens/Verify_Screen.dart';
import 'package:firebase_final/Screens/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({Key? key}) : super(key: key);

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  TextEditingController phoneController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Number Screen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            validator: RequiredValidator(errorText: '*Reauired'),
            controller: phoneController,
            decoration: InputDecoration(labelText: 'Enter Your Phone Number'),
          ),
          ElevatedButton(onPressed: () {
            auth.verifyPhoneNumber(
                phoneNumber: phoneController.text,
                verificationCompleted: (_) {},
                verificationFailed: (e) {
                  utils().toastMessage(e.toString());
                },
                codeSent: (String verificationId, int? token) {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>
                        VerifyScreen(verificationId: verificationId),));
                },
                codeAutoRetrievalTimeout: (e) {
                  utils().toastMessage(e.toString());
                });
          }, child: Text('Submitted'))
        ],
      ),
    );
  }
}
