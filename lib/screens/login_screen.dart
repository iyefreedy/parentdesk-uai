
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:parentdesk_uai/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String firebase_token = '';

  bool _isObscure = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {

    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

    _firebaseMessaging.getToken().then((value) {
      setState(() {
        firebase_token = value!;
      });
    });

    return Scaffold(
      backgroundColor: Colors.indigo,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Center(
          child: _isLoading
              ? CircularProgressIndicator()
              : Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(LAUNCHER_UAI_IMAGE),
                  const Text(
                    'ParentDesk UAI',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24.0,
                      color: Colors.white
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: _nimController,
                    keyboardType: TextInputType.number,
                    validator: (value)  {
                      if(value!.isEmpty) {
                        return 'Harap isi NIM';
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.phone_android, color: Colors.white,),
                      isDense: true,
                      labelText: 'NIM',
                      labelStyle: TextStyle(
                        color: Colors.white
                      ),
                      errorStyle: TextStyle(
                        color: Colors.red[200],
                        fontSize: 14.0
                      )
                    ),
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _isObscure,
                    validator: (value)  {
                      if(value!.isEmpty) {
                        return 'Harap isi password';
                      }
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                      prefixIcon: const Icon(Icons.lock, color: Colors.white,),
                      isDense: true,
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      errorStyle: TextStyle(
                        color: Colors.red[200],
                        fontSize: 14.0
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0)
                        )
                      ),
                      onPressed: () async {
                        if(_formKey.currentState!.validate()) {
                          login(context);
                        }
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w100
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var LOGIN_URL = BASE_URL + "/login/validasi/format/json";

    var response = await post(
        Uri.parse(LOGIN_URL),
        body: {
          "token" : TOKEN_BODY,
          "nim" : _nimController.text,
          "pwd" : _passwordController.text,
          "token_device" : firebase_token
        },
        headers: {
          'token' : TOKEN_HEADER,
          'Authorization' : 'Basic ' + BASIC_AUTH,
        }
    );

    Map<String, dynamic> decodedMap = json.decode(response.body);
    String status = decodedMap["status"];

    if(status == "TRUE") {
      setState(() {
        _isLoading = false;
      });
      prefs.setString("nim", _nimController.text);
      prefs.setString("pwd", _passwordController.text);
      prefs.setBool("logged", true);
      Navigator.pushReplacementNamed(context, '/main');
    } else {
      setState(() {
        _isLoading = false;
      });
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
         return AlertDialog(
           title: Text('Perhatian'),
           content: Text(decodedMap["pesan"]),
           actions: [
             TextButton(
               child: Text('Ok'),
               onPressed: () {
                  Navigator.pop(context);
               },
             )
           ],
         );
        });
    }
  }
}
