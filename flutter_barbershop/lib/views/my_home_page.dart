// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool hidePassword = true;

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
                          onPressed: () {
                            print('เข้าสู่ระบบ');
                            Navigator.pushNamedAndRemoveUntil(context, "/page1",
                                (Route<dynamic> route) => false);
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
