// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);
  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  TextEditingController username = TextEditingController();

  List<String> s1 = ['s', 's', 's'];
  //s1[0];
  Map<String, int> s2 = {'age': 10, 'age2': 10};
  //s2['age']

  List<Map<String, int>> s3 = [
    {'age': 10, 'age2': 10},
    {'age': 10, 'age2': 10}
  ];
  //s3[0][age]

  List<Map<String, String>> items = [
    {'v_id': '1', 'v_name': 'เรดโอ๊ค', 'v_detal': ''},
    {'v_id': '2', 'v_name': 'เรดโอ๊ค1', 'v_detal': ''},
    {'v_id': '3', 'v_name': 'เรดโอ๊2', 'v_detal': ''},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Page1'),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, i) => Card(
            elevation: 10,
            color: Colors.orange,
            child: SizedBox(
              width: double.maxFinite,
              // height: 100,
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ชื่อ : ${items[i]['v_name']}',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        'รายละเอียด : ${items[i]['v_detal']}',
                        style: TextStyle(fontSize: 18),
                      )
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
