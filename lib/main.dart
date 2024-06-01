import 'package:flutter/material.dart';
import 'package:planj_project/constant/colors.dart';

import 'package:planj_project/screen/auth/login_screen.dart';
import 'package:planj_project/screen/currentmappage/presentations/home_view.dart';
import 'package:planj_project/screen/homepage/home_screen.dart';
import 'package:planj_project/screen/onboardingpage/onboarding_screen.dart';
import 'package:planj_project/screen/trafficinfopage/trafficInfo_screen.dart';
import 'package:planj_project/test/testing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PlanJ',
      home: OnboardingScreen(),
    );
  }
}
