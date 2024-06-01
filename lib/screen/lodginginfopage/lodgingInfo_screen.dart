import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:planj_project/constant/colors.dart';

import '../homepage/home_screen.dart';

class LodgingInfoScreen extends StatefulWidget {
  @override
  _LodgingInfoScreenState createState() => _LodgingInfoScreenState();
}

class _LodgingInfoScreenState extends State<LodgingInfoScreen> {


  String? selectedCity;
  String? selectedDistrict;
  DateTime? checkInDate;
  DateTime? checkOutDate;
  String? selectedLodgingType;

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

  List<String> lodgingTypes = ['호텔', '리조트', '콘도미니엄', '펜션', '여관', '민박', '게스트하우스'];

  @override
  Widget build(BuildContext context) {

    final double _screenheight = MediaQuery.of(context).size.height;
    final double _screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: ListView(
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
                      '어떤 숙소를 찾으시나요?',
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
                      'assets/images/lodging_il.png',
                      height: _screenheight * 0.2,
                    ),
                    SizedBox(width: 20,),
                  ],
                ),
                SizedBox(height: 30,),
                Text(
                  '어디로 가시나요?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  hint: Text('도시를 선택하세요'),
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
                    hint: Text('구를 선택하세요'),
                    value: selectedDistrict,
                  ),
                SizedBox(height: 16),
                Text(
                  '언제 필요하신가요?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                ListTile(
                  title: Text('체크인'),
                  subtitle: Text(checkInDate == null ? '날짜 선택' : checkInDate!.toLocal().toString().split(' ')[0]),
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
                              primary: Colors.blue, // 헤더 배경색
                              onPrimary: Colors.white, // 헤더 텍스트 색
                              onSurface: Colors.black, // 날짜 텍스트 색
                            ),
                            dialogBackgroundColor: Colors.white, // 배경색
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (pickedDate != null && pickedDate != checkInDate)
                      setState(() {
                        checkInDate = pickedDate;
                      });
                  },
                ),
                ListTile(
                  title: Text('체크아웃'),
                  subtitle: Text(checkOutDate == null ? '날짜 선택' : checkOutDate!.toLocal().toString().split(' ')[0]),
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
                              primary: Colors.blue, // 헤더 배경색
                              onPrimary: Colors.white, // 헤더 텍스트 색
                              onSurface: Colors.black, // 날짜 텍스트 색
                            ),
                            dialogBackgroundColor: Colors.white, // 배경색
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (pickedDate != null && pickedDate != checkOutDate)
                      setState(() {
                        checkOutDate = pickedDate;
                      });
                  },
                ),
                SizedBox(height: 16),
                Text(
                  '어떤 종류의 숙소를 찾고 계신가요?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  items: lodgingTypes.map((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedLodgingType = value;
                    });
                  },
                  hint: Text('숙소 유형을 선택하세요'),
                  value: selectedLodgingType,
                ),
                SizedBox(height: 16),
                SizedBox(height: 50, width: 250,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('결과 보기'),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  '추천 숙소',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: colorWhite,
            ),
            height: 400, // 고정된 높이 설정
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Card(
                        child: ListTile(
                          leading: Image.network('https://via.placeholder.com/150'),
                          title: Text('김동효의 해변의 집'),
                          subtitle: Text('3 침대 · 2 욕실\n4.93점 / 5점'),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: Image.network('https://via.placeholder.com/150'),
                          title: Text('당진의 바다가 보이는 집'),
                          subtitle: Text('3 침대 · 2 욕실\n4.93점 / 5점'),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: Image.network('https://via.placeholder.com/150'),
                          title: Text('XX호텔'),
                          subtitle: Text('3 침대 · 2 욕실\n4.93점 / 5점'),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: Image.network('https://via.placeholder.com/150'),
                          title: Text('DuzZ Hotel'),
                          subtitle: Text('3 침대 · 2 욕실\n4.93점 / 5점'),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: Image.network('https://via.placeholder.com/150'),
                          title: Text('김동효의 해변의 집'),
                          subtitle: Text('3 침대 · 2 욕실\n4.93점 / 5점'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
