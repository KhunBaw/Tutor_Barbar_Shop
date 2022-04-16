import 'package:flutter/material.dart';

import '../views/page1.dart';
import '../views/register.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/page1': (context) => const Page1(),
  Register.pageName: (context) => const Register(),
};
