  import 'package:flutter/material.dart';
  import 'package:planj_project/constant/colors.dart';

import '../homepage/home_screen.dart';


  class FestivalInfoScreen extends StatefulWidget {
    @override
    _FestivalInfoScreenState createState() => _FestivalInfoScreenState();
  }

  class _FestivalInfoScreenState extends State<FestivalInfoScreen> {
    String? searchKeyword;
    String? selectedCity;
    String? selectedDistrict;
    DateTime? selectedDate;
    List<Map<String, String>> festivals = [
      {'title': '벚꽃축제', 'city': '대전', 'date': '2024/2/24~2024/3/8', 'details': 'A beautiful festival celebrating cherry blossoms.'},
      {'title': '충남대학교 축제', 'city': '대전', 'date': '2024/4/15~2024/4/20', 'details': '충남대학교의 대표적인 축제는 \'대동제\'입니다. 대동제는 매년 봄 학기에 열리며,\n 학생들이 함께 어울려 즐길 수 있는 다양한 프로그램과 행사를 제공합니다.\n 대동제는 학교 공동체 의식을 강화하고, 학생들의 스트레스를 해소하며,\n 문화와 예술을 즐길 수 있는 기회를 제공하기 위해 기획됩니다.'},
      {'title': '부산대 축제', 'city': '부산', 'date': '2024/8/10~2024/8/15', 'details': 'A large music and arts festival.'}
    ];

    List<String> cities = [
      '서울', '부산', '대구', '인천', '광주', '대전', '울산', '세종',
      '경기', '강원', '충북', '충남', '전북', '전남', '경북', '경남', '제주'
    ];

    Map<String, List<String>> districts = {
      '서울': ['강남구', '강동구', '강북구', '강서구', '관악구', '광진구', '구로구', '금천구', '노원구', '도봉구', '동대문구', '동작구', '마포구', '서대문구', '서초구', '성동구', '성북구', '송파구', '양천구', '영등포구', '용산구', '은평구', '종로구', '중구', '중랑구'],
      '부산': ['강서구', '금정구', '기장군', '남구', '동구', '동래구', '부산진구', '북구', '사상구', '사하구', '서구', '수영구', '연제구', '영도구', '중구', '해운대구'],
      '대구': ['남구', '달서구', '달성군', '동구', '북구', '서구', '수성구', '중구'],
      '인천': ['강화군', '계양구', '미추홀구', '남동구', '동구', '부평구', '서구', '연수구', '중구'],
      '광주': ['광산구', '남구', '동구', '북구', '서구'],
      '대전': ['대덕구', '동구', '서구', '유성구', '중구'],
      '울산': ['남구', '동구', '북구', '울주군', '중구'],
      '세종': ['세종시'],
      '경기': ['가평군', '고양시', '과천시', '광명시', '광주시', '구리시', '군포시', '김포시', '남양주시', '동두천시', '부천시', '성남시', '수원시', '시흥시', '안산시', '안성시', '안양시', '양주시', '양평군', '여주시', '연천군', '오산시', '용인시', '의왕시', '의정부시', '이천시', '파주시', '평택시', '포천시', '하남시', '화성시'],
      '강원': ['강릉시', '고성군', '동해시', '삼척시', '속초시', '양구군', '양양군', '영월군', '원주시', '인제군', '정선군', '철원군', '춘천시', '태백시', '평창군', '홍천군', '화천군', '횡성군'],
      '충북': ['괴산군', '단양군', '보은군', '영동군', '옥천군', '음성군', '제천시', '증평군', '진천군', '청주시', '충주시'],
      '충남': ['계룡시', '공주시', '금산군', '논산시', '당진시', '보령시', '부여군', '서산시', '서천군', '아산시', '연기군', '예산군', '천안시', '청양군', '태안군', '홍성군'],
      '전북': ['고창군', '군산시', '김제시', '남원시', '무주군', '부안군', '순창군', '완주군', '익산시', '임실군', '장수군', '전주시', '정읍시', '진안군'],
      '전남': ['강진군', '고흥군', '곡성군', '광양시', '구례군', '나주시', '담양군', '목포시', '무안군', '보성군', '순천시', '신안군', '여수시', '영광군', '영암군', '완도군', '장성군', '장흥군', '진도군', '함평군', '해남군', '화순군'],
      '경북': ['경산시', '경주시', '고령군', '구미시', '군위군', '김천시', '문경시', '봉화군', '상주시', '성주군', '안동시', '영덕군', '영양군', '영주시', '영천시', '예천군', '울릉군', '울진군', '의성군', '청도군', '청송군', '칠곡군', '포항시'],
      '경남': ['거제시', '거창군', '고성군', '김해시', '남해군', '밀양시', '사천시', '산청군', '양산시', '의령군', '진주시', '창녕군', '창원시', '통영시', '하동군', '함안군', '함양군', '합천군'],
      '제주': ['서귀포시', '제주시']
    };
    int expandedCardIndex = -1;

    @override
    Widget build(BuildContext context) {

      final double _screenheight = MediaQuery.of(context).size.height;
      final double _screenwidth = MediaQuery.of(context).size.width;

      return Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: ListView(
            physics: AlwaysScrollableScrollPhysics(),
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                      children: [
                        GestureDetector(
                          onTap:() {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const HomeScreen()),
                            );
                          },
                          child: Icon(Icons.arrow_back_ios_rounded,
                            color: colorWhite,),
                        ),
                        Text(
                          '어떤 지역의 축제를 찾으시나요?',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(width: 10,),
                      ],
                    ),
                    SizedBox(height: _screenheight * 0.1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          'assets/images/festival_il.png',
                          height: _screenheight * 0.2,
                        ),
                        SizedBox(width: 20,),
                      ],
                    ),
                    SizedBox(height: 30,),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for festivals',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchKeyword = value;
                        });
                      },
                    ),
                    SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                      ),
                      items: cities.map((city) {
                        return DropdownMenuItem<String>(
                          value: city,
                          child: Text(city),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCity = value;
                          selectedDistrict = null;
                        });
                      },
                      hint: Text('지역을 선택하세요'),
                      value: selectedCity,
                    ),
                    SizedBox(height: 8),
                    if (selectedCity != null)
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                        ),
                        items: districts[selectedCity]!.map((district) {
                          return DropdownMenuItem<String>(
                            value: district,
                            child: Text(district),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedDistrict = value;
                          });
                        },
                        hint: Text('지역을 선택하세요'),
                        value: selectedDistrict,
                      ),
                    SizedBox(height: 16),
                    // Date selection widget
                    ListTile(
                      title: Text('날짜'),
                      subtitle: Text(selectedDate == null ? '선택한 날짜' : selectedDate!.toString().split(' ')[0]),
                      trailing: Icon(Icons.calendar_today),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: Colors.blue,
                                  onPrimary: Colors.white,
                                  onSurface: Colors.black,
                                ),
                                dialogBackgroundColor: Colors.white,
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (pickedDate != null && pickedDate != selectedDate) {
                          setState(() {
                            selectedDate = pickedDate;
                          });
                        }
                      },
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
              Container(
                constraints: BoxConstraints.tightFor(height: _screenheight * 0.4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: colorWhite,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: festivals.length,
                  itemBuilder: (context, index) {
                    final festival = festivals[index];
                    final startDate = _parseFestivalDate(festival['date']!.split('~')[0]);
                    final endDate = _parseFestivalDate(festival['date']!.split('~')[1]);
                    // Filter by keyword, date, and city
                    if ((searchKeyword != null && !festival['title']!.toLowerCase().contains(searchKeyword!.toLowerCase())) ||
                        (selectedDate != null && !isFestivalDateContained(startDate, endDate, selectedDate!)) ||
                        (selectedCity != null && festival['city'] != selectedCity)) {
                      return SizedBox.shrink(); // Hide festivals that don't match the filters
                    }
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          expandedCardIndex = expandedCardIndex == index ? -1 : index;
                        });
                      },
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text(festival['title']!),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('지역: ${festival['city']}'),
                                  Text('축제 일정: ${festival['date']}'),
                                ],
                              ),
                            ),
                            if (expandedCardIndex == index)
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(festival['details']!),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
    DateTime _parseFestivalDate(String dateString) {
      final parts = dateString.split('~');
      final startDateParts = parts[0].split('/');
      final startYear = int.parse(startDateParts[0]);
      final startMonth = int.parse(startDateParts[1]);
      final startDay = int.parse(startDateParts[2]);
      return DateTime(startYear, startMonth, startDay);
    }
    bool isFestivalDateContained(DateTime startDate, DateTime endDate, DateTime selectedDate) {
      return selectedDate.isAfter(startDate.subtract(Duration(days: 1))) && selectedDate.isBefore(endDate.add(Duration(days: 1)));
    }
  }