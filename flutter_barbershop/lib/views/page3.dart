import 'package:flutter/material.dart';

class Page3 extends StatefulWidget {
  const Page3({Key? key, required this.data}) : super(key: key);

  final dynamic data;

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.data['username']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page3'),
      ),
      body: SafeArea(
          child: Column(children: [
        Text('ชื่อผู้ใช้ ${widget.data['username']}'),
        Text('ชื่อ ${widget.data['emp_fname']}')
      ])),
    );
  }
}
