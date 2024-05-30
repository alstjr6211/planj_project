//Custom Widget 하는 페이지
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planj_project/constant/colors.dart';
import 'package:planj_project/constant/size.dart';

import '../screen/currentmappage/presentations/home_view.dart';
import '../screen/homepage/home_screen.dart';
import '../screen/settingpage/setting_screen.dart';
//텍스트 스타일 지정문. font 고정, 텍스트, 폰트 사이즈, 색, 굵기 유무를 인자로 받음


Widget customTextStyle(String text, double size, Color color, bool bold) {
  return Text(
    text,
    style: TextStyle(
      fontFamily: "",
      color: color,
      fontSize: size,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    ),
  );
}

//------or------ 위젯
Widget orDividor(double screenwidth) {
  return Container(
    alignment: Alignment.center,
    width: screenwidth * 0.92,
    child: Row(
      children: [
        const Expanded(
          child: Divider(color: Colors.grey, thickness: 0.7),
        ),
        const SizedBox(height: 0, width: 10,),
        customTextStyle("or", 14, colorBlack, false),
        const SizedBox(height: 0, width: 10,),
        const Expanded(
          child: Divider(color: Colors.grey, thickness: 0.7),
        ),
      ],
    ),
  );
}

Widget customBottomNavigationBar(int selectedIndex, BuildContext context) {
  void _onItemTapped(int index) {
    late Widget nextPage;

    switch (index) {
      case 0:
        nextPage = const MapHomeScreen();
        break;
      case 1:
        nextPage = const HomeScreen();
        break;
      case 2:
        nextPage = const SettingScreen();
        break;
    }

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => nextPage,
      ),
    );
  }

  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    backgroundColor: bottomBarColor,
    elevation: 1,
    currentIndex: selectedIndex,
    onTap: _onItemTapped,
    items: [
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'assets/icons/chattingroomButton.svg',
          color: colorGrey,
          height: bottomNavigationBarItemSize,
        ),
        activeIcon: SvgPicture.asset(
          'assets/icons/chattingroomButton.svg',
          color: blueStyle_2,
          height: bottomNavigationBarItemSize,
        ),
        label: '채팅',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'assets/icons/homeButton.svg',
          color: colorGrey,
          height: bottomNavigationBarItemSize,
        ),
        activeIcon: SvgPicture.asset(
          'assets/icons/homeButton.svg',
          color: blueStyle_2,
          height: bottomNavigationBarItemSize,
        ),
        label: '홈',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'assets/icons/viewmoreButton.svg',
          color: colorGrey,
          height: bottomNavigationBarItemSize,
        ),
        activeIcon: SvgPicture.asset(
          'assets/icons/viewmoreButton.svg',
          color: blueStyle_2,
          height: bottomNavigationBarItemSize,
        ),
        label: '유저',
      ),
    ],
  );
}


