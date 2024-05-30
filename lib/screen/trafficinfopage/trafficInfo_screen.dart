import 'package:flutter/material.dart';
import 'package:planj_project/constant/colors.dart';
import 'package:intl/intl.dart';
import 'package:planj_project/screen/homepage/home_screen.dart';


class TrafficInfoScreen extends StatefulWidget {
  @override
  _TrafficInfoScreenState createState() => _TrafficInfoScreenState();
}

class _TrafficInfoScreenState extends State<TrafficInfoScreen> {
  final TextEditingController _startLocationController = TextEditingController();
  final TextEditingController _endLocationController = TextEditingController();
  String? _selectedTransport;
  bool _isTransportSelected = false;

  DateTime? _selectedDate;

  String _transportMessage = '';

  void _updateTransportMessage(String? transport) {
    switch (transport) {
      case '택시':
        _transportMessage = '이동 할 수 있는 택시를 표시합니다.';
        break;
      case '버스':
        _transportMessage = '이동 할 수 있는 버스를 표시합니다.';
        break;
      case '시외버스':
        _transportMessage = '이동 할 수 있는 시외버스를 표시합니다.';
        break;
      case '기차':
        _transportMessage = '이동 할 수 있는 기차를 표시합니다.';
        break;
      default:
        _transportMessage = '해당 정보가 없습니다.';
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final _screenwidth = MediaQuery.of(context).size.width;
    final _screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(height: 20,),
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
                      '어디로 이동하실 건가요?',
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
                      'assets/images/bus_image.png',
                      height: _screenheight * 0.2,
                    ),
                    SizedBox(width: 20,),
                  ],
                ),
                SizedBox(height: 30,),
                SizedBox(
                  height: 50, width: _screenwidth * 0.9,
                  child: TextField(
                    controller: _startLocationController,
                    decoration: InputDecoration(
                      hintText: '출발 장소를 입력해주세요.',
                      hintStyle: TextStyle(
                        color: colorWhite,
                      ),
                      counterText: "",
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: colorWhite,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: colorWhite,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                SizedBox(height: 50, width: _screenwidth * 0.9,
                  child: TextField(
                    controller: _endLocationController,
                    decoration: InputDecoration(
                      hintText: '도착 장소를 입력해주세요.',
                      hintStyle: TextStyle(
                        color: colorWhite,
                      ),
                      counterText: "",
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: colorWhite,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: colorWhite,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  width: _screenwidth * 0.9,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => _selectDate(context),
                    child: Text(_selectedDate == null
                        ? '교통수단 이용 날짜를 선택하십시오'
                        : '선택한 날짜: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}'),
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: colorWhite,
              ),
              height: _screenheight * 0.4,
              width: _screenwidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: _screenwidth * 0.8,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: Text('이동하려는 교통수단을 선택하세요'),
                      value: _selectedTransport,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedTransport = newValue;
                          _isTransportSelected = newValue != null;
                          _updateTransportMessage(newValue);
                        });
                      },
                      items: <String>['택시', '버스', '시외버스', '기차']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    _isTransportSelected ? _transportMessage : '해당 정보가 없습니다',
                    style: TextStyle(color: _isTransportSelected ? Colors.black : Colors.red),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}