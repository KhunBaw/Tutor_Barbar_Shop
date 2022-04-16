import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../components/textFormFieldModel.dart';

class Register extends StatefulWidget {
  static const String pageName = '/register';
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController conpassword = TextEditingController();
  TextEditingController picdate = TextEditingController();
  TextEditingController pictime = TextEditingController();

  DateTime? datenow = DateTime.now();

  String? dropdownValue = 'a';

  List<DropdownMenuItem<String>>? items = [
    const DropdownMenuItem(
      value: 'a',
      child: Text('a', style: TextStyle(color: Colors.red)),
    ),
    const DropdownMenuItem(
      value: 'b',
      child: Text('b'),
    ),
    const DropdownMenuItem(
      value: 'c',
      child: Text('c'),
    ),
  ];

  List<DropdownMenuItem<String>>? items2 = ['a', 'b', 'c', 'd'].map((String e) {
    return DropdownMenuItem(
      value: e,
      child: Text(e),
    );
  }).toList();

  @override
  Widget build(BuildContext context) {
    void newDate() async {
      DateTime? date = await showDatePicker(
        context: context,
        initialDate: datenow!,
        firstDate: DateTime(DateTime.now().year, DateTime.now().month, 1),
        lastDate: DateTime(DateTime.now().year, DateTime.now().month, 25),
      );

      if (date != null) {
        setState(() {
          datenow = date;
          picdate.text = DateFormat("dd/MM/yyyy").format(date);
        });
      }
    }

    void newTime() async {
      TimeOfDay? time =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());

      if (time != null) {
        setState(() {
          // datenow = date;
          pictime.text = '${time.hour}:${time.minute}';
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(5, 10, 5, 20),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border.all(color: const Color(0xFF616161), width: 2),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Column(children: [
              TextFormFieldModel(labelText: 'username', controller: username),
              const SizedBox(
                height: 10,
              ),
              TextFormFieldModel(labelText: 'password', controller: password),
              const SizedBox(
                height: 10,
              ),
              TextFormFieldModel(
                  labelText: 'conpassword', controller: conpassword),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: picdate,
                style: TextStyle(color: Colors.black),
                readOnly: true,
                onTap: () {
                  newDate();
                },
                decoration: const InputDecoration(
                  labelText: 'วันที่',
                  // hintText: hintText,
                  labelStyle: TextStyle(color: Colors.black),
                  hintStyle: TextStyle(color: Colors.black),

                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 1.5),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink, width: 3),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: pictime,
                style: TextStyle(color: Colors.black),
                readOnly: true,
                onTap: () {
                  newTime();
                },
                decoration: const InputDecoration(
                  labelText: 'เวลา',
                  // hintText: hintText,
                  labelStyle: TextStyle(color: Colors.black),
                  hintStyle: TextStyle(color: Colors.black),

                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 1.5),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink, width: 3),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                value: dropdownValue,
                items: items,
                onChanged: (value) {
                  print(value);
                  setState(() {
                    dropdownValue = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'เลือก',
                  // hintText: hintText,
                  labelStyle: TextStyle(color: Colors.black),
                  hintStyle: TextStyle(color: Colors.black),

                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 1.5),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink, width: 3),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
