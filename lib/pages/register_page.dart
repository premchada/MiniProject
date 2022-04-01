import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:projectbakery/services/autth_service.dart';

FirebaseAuth auth = FirebaseAuth.instance; //auth on firebase
FirebaseFirestore firestore = FirebaseFirestore.instance;
GoogleSignIn googleSignIn = GoogleSignIn();

Future<UserCredential?> registerUser(
     email,password,name) async {
  try {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    print(userCredential.user!.uid);
    CollectionReference users = FirebaseFirestore.instance.collection('Users');

    users
        .add({
          'name': name,
          'uid_id': userCredential.user!.uid,
        })
       
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
    return userCredential;
  } on FirebaseAuthException catch (e) {
    print(e.code);
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
  return null;
}


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff89dad0),
        title: Text('register'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(children: [
          nameInput(),
          emailInput(),
          paaswordInput(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          regisButton(),
        ]),
      )),
    );
  }

  Widget nameInput() {
    return SizedBox(
      width: 250,
      child: TextFormField(
        controller: _name,
        decoration: const InputDecoration(
            hintText: "input your name", prefixIcon: Icon(Icons.person)),
      ),
    );
  }

  Widget emailInput() {
    return SizedBox(
      width: 250,
      child: TextFormField(
        controller: _email,
        decoration: const InputDecoration(
            hintText: "input your email", prefixIcon: Icon(Icons.email)),
      ),
    );
  }

  Widget paaswordInput() {
    return SizedBox(
      width: 250,
      child: TextFormField(
        controller: _pass,
        obscureText: true,
        decoration: const InputDecoration(
            hintText: "input password", prefixIcon: Icon(Icons.password)),
      ),
    );
  }

  regisButton() {
    return Container(
      height: 50,
      width: 115,
      decoration: BoxDecoration(
        color: Color(0xFFffd28d),
        //border: Border.all(color: Colors.grey.withOpacity(0.4), width: 1),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Icon(icon, size: 24),
          TextButton(
              onPressed: () {
                registerUser(_email.text, _pass.text, _name.text).then((value) {
                  Navigator.pop(context);
                });
              },
              child: Text(
                'ลงทะเบียน',
                style: TextStyle(color: Colors.brown[800]),
              )),
        ],
      ),
    );
    // return Center(
    //   child: Column(
    //     mainAxisSize: MainAxisSize.min,
    //     children: <Widget>[
    //       ElevatedButton(
    //         onPressed: () {
    //           // loginUser(_email.text, _pass.text);
    //           // registerUser(_email.text, _pass.text, _name.text).then((value) {
    //           //   Navigator.pop(context);
    //           // }
    //           // );
    //         },
    //         child: const Text('Regiser'),
    //       ),
    //     ],
    //   ),
    // );
  }
}
