import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../constant/colors.dart';
import '../../constant/widget.dart';


class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = 2;


    final double _screenheight = MediaQuery.of(context).size.height;
    final double _screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: blueStyle_3,
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: ListView(
              children: [
                _SingleSection(
                  title: "일반",
                  children: [
                    const _CustomListTile(
                        title: "휴대폰 설정",
                        icon: CupertinoIcons.device_phone_portrait),
                    _CustomListTile(
                        title: "다크 모드",
                        icon: CupertinoIcons.moon,
                        trailing:
                        CupertinoSwitch(value: false, onChanged: (value) {})),
                    const _CustomListTile(
                        title: "알림 설정",
                        icon: CupertinoIcons.alarm),
                    const _CustomListTile(
                        title: "어플리케이션 정보",
                        icon: CupertinoIcons.lock_shield),
                  ],
                ),
                _SingleSection(
                  title: "앱 정보",
                  children: [
                    const _CustomListTile(
                        title: "오픈소스 라이센스",
                        icon: Icons.sd_card_outlined),
                    const _CustomListTile(
                        title: "버전 V 1.0",
                        icon: CupertinoIcons.settings),
                  ],
                ),
                const _SingleSection(
                  title: "약관 및 정책",
                  children: [
                    _CustomListTile(
                        title: "서비스 이용약관", icon: CupertinoIcons.person_2),
                    _CustomListTile(
                        title: "개인정보 처리방침", icon: CupertinoIcons.lock),
                    _CustomListTile(
                        title: "위치기반 서비스 이용약관", icon: CupertinoIcons.map),
                    _CustomListTile(
                        title: "앱 지원",
                        icon: CupertinoIcons.speaker_2),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: customBottomNavigationBar(selectedIndex, context),
    );
  }
}



class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  const _CustomListTile(
      {Key? key, required this.title, required this.icon, this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing: trailing ?? const Icon(CupertinoIcons.forward, size: 18),
      onTap: () {},
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _SingleSection({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title.toUpperCase(),
            style:
            Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 16),
          ),
        ),
        Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}
