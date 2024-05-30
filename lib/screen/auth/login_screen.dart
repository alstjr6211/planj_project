//로그인 페이지, 로그인 인증 token이 발급되지 않으면 실행할 페이지

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/rendering.dart';
import 'package:planj_project/constant/colors.dart';
import 'package:planj_project/constant/widget.dart';

import '../homepage/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {

    final double _screenheight = MediaQuery.of(context).size.height;
    final double _screenwidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        width: _screenwidth,
        height: _screenheight,
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: SafeArea(
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    height: _screenheight * 0.55,
                    width: _screenwidth,
                    color: colorGrey,
                  ),
                ),
                Positioned(
                  top: _screenheight * 0.08,
                  left: _screenwidth * 0.5 - 50,
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.asset(
                      'assets/logos/planJ_logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Container(
                      height: _screenheight * 0.7 - 60,
                      width: _screenwidth - 60,
                      decoration: BoxDecoration (
                        color: colorWhite,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: ListView(
                          children: [
                            customTextStyle("Log-in", 32, colorBlack,true),
                            const SizedBox(height: 20,),
                            SizedBox(
                              height: _screenheight * 0.6 - 80,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {

                                    },
                                    child: Container(
                                      width: _screenwidth - 100,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: blueStyle_2, width: 2),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const SizedBox(height: 0, width: 10,),
                                          const SizedBox(height: 0, width: 10,),
                                          Container(
                                            width: 40,
                                            height: 40,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(8),
                                              child: Image.asset(
                                                'assets/logos/apple_logo.png',
                                                fit: BoxFit.fitHeight,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 0, width: 20,),
                                          customTextStyle("애플로 시작하기", 16, colorBlack, false),
                                          const SizedBox(height: 0, width: 10,),
                                          const SizedBox(height: 0, width: 10,),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                                      );
                                    },
                                    child: Container(
                                      width: _screenwidth - 100,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: blueStyle_2, width: 2),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const SizedBox(height: 0, width: 10,),
                                          const SizedBox(height: 0, width: 10,),
                                          Container(
                                            width: 40,
                                            height: 40,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(8),
                                              child: Image.asset(
                                                'assets/logos/google_logo.png',
                                                fit: BoxFit.fitHeight,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 0, width: 20,),
                                          customTextStyle("구글로 시작하기", 16, colorBlack, false),
                                          const SizedBox(height: 0, width: 10,),
                                          const SizedBox(height: 0, width: 10,),
                                        ],
                                      ),
                                    ),
                                  ),
                                  orDividor(_screenwidth),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        child: GestureDetector(
                                          onTap: () {

                                          },
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: Image.asset(
                                              'assets/logos/naver_logo.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 50,
                                        height: 50,
                                        child: GestureDetector(
                                          onTap: () {

                                          },
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: SvgPicture.asset(
                                              'assets/logos/kakao_logo.svg',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}
