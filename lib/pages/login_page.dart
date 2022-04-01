import 'package:auth_buttons/auth_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectbakery/main.dart';
import 'package:projectbakery/pages/register_page.dart';
import 'package:projectbakery/services/autth_service.dart';
import 'homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(32.5),
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Container(
                height: 213,
                //color: Colors.amber,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('images/bakery.png'),
                ))),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            const Text(
              'data',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            emailInput(),
            paaswordInput(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            signinButton(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            signupButton(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            const Divider(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            // GoogleAuthButton(
            //   onPressed: () async {
            //     signInWithGoogle().then((value) {
            //       Navigator.pushReplacement(
            //         context,
            //         MaterialPageRoute(
            //           builder: ((context) => const HomePage()),
            //         ));
            //     });
                
            //     // your implementation
            //   },
            //   darkMode: false,
            // ),
            Container(),
          ],
        ),
      ),

      
    );
  }

  Widget emailInput() {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 236, 236, 236),
          borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25),
        child: TextField(
          controller: _email,
          decoration: InputDecoration(
            labelText: 'E-mail',
            //hintText: hintTitle,
            hintStyle: TextStyle(
                fontSize: 18,
                color: Colors.white70,
                fontStyle: FontStyle.italic),
          ),
          //keyboardType: keyboardType,
        ),
      ),
    );
    // return SizedBox(
    //   width: 250,
    //   child: TextFormField(
    //     controller: _email,
    //     decoration: const InputDecoration(prefixIcon: Icon(Icons.email)),
    //   ),
    // );
  }

  Widget paaswordInput() {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 236, 236, 236),
          borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25),
        child: TextField(
          controller: _pass,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            //hintText: hintTitle,
            hintStyle: TextStyle(
                fontSize: 18,
                color: Colors.white70,
                fontStyle: FontStyle.italic),
          ),
          // keyboardType: keyboardType,
        ),
      ),
    );

    // return SizedBox(
    //   width: 250,
    //   child: TextFormField(
    //     controller: _pass,
    //     obscureText: true,
    //     decoration: const InputDecoration(prefixIcon: Icon(Icons.password)),
    //   ),
    // );
  }

  signupButton() {
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => RegisterPage()),
                    ));
              },
              child: Text(
                'ลงทะเบียน',
                style: TextStyle(color: Colors.brown[800]),
              )),
        ],
      ),
    );
    
  }

  signinButton() {
    return Container(
      height: 50,
      width: 115,
      decoration: BoxDecoration(
        color: Color(0xFFfcab88),
        //border: Border.all(color: Colors.grey.withOpacity(0.4), width: 1),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Icon(icon, size: 24),
          TextButton(
              onPressed: () async {
                //if (_formKey.currentState!.validate()) {
                  loginUser(_email.text, _pass.text);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => MyHomePage()),
                      ));
                },
              //},
              child: Text(
                'เข้าสู่ระบบ',
                style: TextStyle(color: Colors.brown[800]),
              )),
        ],
      ),
    );
    
  }
}
