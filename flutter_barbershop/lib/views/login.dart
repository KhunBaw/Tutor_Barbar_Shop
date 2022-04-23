// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config/config.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool hidePassword = true;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    super.initState();
    chackToken();
  }

  chackToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print(token);
    if (token != null) {
      headers?['Authorization'] = "bearer $token";
      Navigator.pushReplacementNamed(context, "/page1");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      // appBar: AppBar(
      //   title: const Text('หัวแอป'),
      //   centerTitle: true,
      //   backgroundColor: Colors.orange[600],
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                SizedBox(
                  height: 10,
                ),
                Image.asset(
                  'assets/images/LOGO.png',
                  height: 250,
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Form(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: username,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Username',
                            hintText: 'ชื่อผู้ใช้',
                            labelStyle: TextStyle(color: Colors.white),
                            hintStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.pink, width: 3),
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.account_circle,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: password,
                          obscureText: hidePassword,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'รหัสผ่าน',
                            labelStyle: TextStyle(color: Colors.white),
                            hintStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.pink, width: 3),
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.password,
                              size: 30,
                              color: Colors.white,
                            ),
                            suffixIcon: IconButton(
                              onPressed: (() {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              }),
                              icon: Icon(
                                hidePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            print('เข้าสู่ระบบ');
                            await chackLogin(
                                username.text, password.text, context);
                            // Navigator.pushReplacementNamed(context, "/page2");
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => Page1(),
                            //   ),
                            // );
                          },
                          child: Text(
                            'เข้าสู่ระบบ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            primary: Colors.pink,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            print('สมัครสมาชิก');
                            Navigator.pushNamed(context, "/register");
                          },
                          child: Text(
                            'สมัครสมาชิก',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            primary: Colors.pink,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future chackLogin(String username, String password, context) async {
  Uri url = Uri.parse('http://192.168.1.2:3000/api/v1/employee/login');
  await http
      .post(
    url,
    headers: headers,
    body: jsonEncode(
      {"username": username, "password": password},
    ),
  )
      .then((req) async {
    if (req.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      var data = jsonDecode(req.body);
      prefs.setString('token', data['token']);
      headers?['Authorization'] = "bearer ${data['token']}";
      Navigator.pushReplacementNamed(context, "/page1");
    } else {
      print('error');
    }
  });
}
