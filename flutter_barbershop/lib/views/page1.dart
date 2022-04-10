// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../components/textFormFieldModel.dart';

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);
  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  TextEditingController username = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Page1'),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            TextFormFieldModel(labelText: 'username', controller: username),
            Text('username : ' + username.text),
            TextFormFieldModel(labelText: 'user'),
          ],
        ),
      ),
    );
  }
}
