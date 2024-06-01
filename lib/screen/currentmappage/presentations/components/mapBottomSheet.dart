import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:planj_project/screen/currentmappage/core/services/location_services.dart';

// BottomSheet에 표시될 각 장소의 카드 위젯
class PlaceCard extends StatelessWidget {
  final String name;
  final double distance;

  const PlaceCard({required this.name, required this.distance});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(name),
        subtitle: Text('${distance.toStringAsFixed(1)} km away'),
        onTap: () {
          //TODO 카드를 탭 하면 자세한 정보창 이동
        },
      ),
    );
  }
}

// BottomSheet 위젯
class MapBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 여행지 카드들을 여기에 추가합니다.
          PlaceCard(name: '한밭대학교', distance: 8.8),
          PlaceCard(name: '대전 신세계백화점', distance: 3.8),
          PlaceCard(name: 'Place 3', distance: 5.0),
        ],
      ),
    );
  }
}