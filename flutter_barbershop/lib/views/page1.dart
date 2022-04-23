// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../config/config.dart';
import 'page3.dart';

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

  dynamic data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startAPI();
  }

  startAPI() async {
    var item = await getData();
    setState(() {
      data = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Page1'),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: RefreshIndicator(
          onRefresh: () async {
            await startAPI();
          },
          child: ListView.builder(
            itemCount: data?.length ?? 0,
            itemBuilder: (context, i) => InkWell(
              onTap: () {
                print('object');
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => Page3(data: data[i]),
                  ),
                );
              },
              child: Card(
                elevation: 10,
                color: Colors.orange,
                child: SizedBox(
                  width: double.maxFinite,
                  // height: 100,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/images/LOGO.png'),
                          radius: 30,
                          backgroundColor: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ชื่อผู้ใช้ : ${data![i]['username']}',
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                'ชื่อ : ${data![i]['emp_fname']} ${data![i]['emp_lname']}',
                                style: TextStyle(fontSize: 18),
                              )
                            ]),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<dynamic> getData() async {
  Uri url = Uri.parse('http://192.168.1.2:3000/api/v1/employee');
  return await http
      .get(
    url,
    headers: headers,
  )
      .then((req) async {
    print(req.statusCode);
    if (req.statusCode == 200) {
      var data = json.decode(req.body);
      return data;
    } else {
      print('error');
      return [];
    }
  });
}
