import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:planj_project/constant/colors.dart';
import 'package:planj_project/screen/festivalinfopage/festivalInfo_screen.dart';
import 'package:planj_project/screen/lodginginfopage/lodgingInfo_screen.dart';

import '../../constant/widget.dart';
import '../trafficinfopage/trafficInfo_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {

    int selectedIndex = 1;


    final double _screenheight = MediaQuery.of(context).size.height;
    final double _screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Container(
          width: _screenwidth,
          height: _screenheight,
          color: colorWhite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: _screenheight * 0.24,
                width: _screenwidth,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  color: backgroundColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "최근엔 [대전] 여행을 검색하셨네요?\n[대전] 여행지를 찾아보시겠습니까?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "[대전] 근처 여행지 검색 바로가기",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("다른 지역 검색하기",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Icon(
                          Icons.search
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: _screenheight * 0.76 - 58,
                width: _screenwidth,
                color: colorWhite,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 44,
                  ),
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                '어서오세요!',
                                style: TextStyle(
                                  fontSize: 22,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                '원하는 정보 탭을\n선택하세요.',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      courseLayout(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: customBottomNavigationBar(selectedIndex, context),
    );
  }
}


Widget courseLayout(BuildContext context) {
  List<String> imageFileList = [
    'redBus.png',
    'lodging.png',
    'festival.png',
    'email.png',
  ];

  List<Color> colorList = [
    blueStyle_1,
    blueStyle_2,
    blueStyle_3,
    colorGrey,
  ];

  return MasonryGridView.count(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    crossAxisCount: 2,
    mainAxisSpacing: 27,
    crossAxisSpacing: 23,
    itemCount: imageFileList.length,
    itemBuilder: (context, index) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          color: colorList[index],
          child: GestureDetector(
            onTap: () {
              switch (index) {
                case 0:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TrafficInfoScreen()),
                  );
                  break;
                case 1:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LodgingInfoScreen()),
                  );
                  break;
                case 2:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FestivalInfoScreen()),
                  );
                  break;
                case 3:
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      String mailTitle = '';
                      String mailContent = '';

                      return AlertDialog(
                        title: Text('문의하기'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            TextField(
                              onChanged: (value) {
                                mailTitle = value;
                              },
                              decoration: InputDecoration(labelText: '메일 제목'),
                            ),
                            SizedBox(height: 20),
                            TextField(
                              onChanged: (value) {
                                mailContent = value;
                              },
                              decoration: InputDecoration(labelText: '내용'),
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // 다이얼로그 닫기
                            },
                            child: Text('취소'),
                          ),
                          TextButton(
                            onPressed: () {
                              // 여기에 메일 보내는 로직 추가
                              // mailTitle과 mailContent를 사용하여 메일을 보내는 함수를 호출하세요.

                              Navigator.of(context).pop(); // 다이얼로그 닫기
                            },
                            child: Text('보내기'),
                          ),
                        ],
                      );
                    },
                  );
                  break;
              }
            },
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Image.asset(
                'assets/icons/${imageFileList[index]}',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      );
    },
  );
}
