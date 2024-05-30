import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:geolocator/geolocator.dart';
import 'package:image/image.dart' as img;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:planj_project/constant/colors.dart';
import 'package:planj_project/screen/currentmappage/core/config.dart';
import 'package:planj_project/screen/currentmappage/core/model/place_prediction_model.dart';
import 'package:planj_project/screen/currentmappage/core/services/location_services.dart';
import 'package:planj_project/screen/currentmappage/presentations/place_details_view.dart';

import '../../../constant/widget.dart';
import 'components/custom_marker_card.dart';
import 'components/mapBottomSheet.dart';

class MapHomeScreen extends StatefulWidget {
  const MapHomeScreen({super.key});

  @override
  State<MapHomeScreen> createState() => _MapHomeScreenState();
}

class _MapHomeScreenState extends State<MapHomeScreen> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();
  final CustomInfoWindowController _customInfoWindowController =
  CustomInfoWindowController();
  Set<Marker> markers = <Marker>{};
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  TextEditingController _searchController = TextEditingController();

  // 이미지 리사이징 함수
  Future<Uint8List> resizeImage(Uint8List imageData, int width, int height) async {
    img.Image? image = img.decodeImage(imageData);
    if (image != null) {
      img.Image resized = img.copyResize(image, width: width, height: height);
      Uint8List resizedBytes = Uint8List.fromList(img.encodePng(resized));
      return resizedBytes;
    } else {
      throw Exception('Failed to resize image: Image is null.');
    }
  }
  //현재 위치를 가져오는 함수
  _getCurrentPosition() async {
    final currentLocation = await LocationService.getCurrentPosition();
    final cameraPosition = CameraPosition(
      target: LatLng(currentLocation.latitude, currentLocation.longitude),
      zoom: 19.151926040649414,
    );
    final controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));


    //현재 위치를 가져오는 마커 생성

    ByteData byteData = await rootBundle.load('assets/marker/location_now.png');
    Uint8List markerIconBytes = byteData.buffer.asUint8List();

    markerIconBytes = await resizeImage(markerIconBytes, 70, 70);
    // 현재 위치를 나타내는 마커를 생성
    final Marker currentLocationMarker = Marker(
      markerId: MarkerId('currentLocationMarker'),
      position: LatLng(currentLocation.latitude, currentLocation.longitude),
      icon: BitmapDescriptor.fromBytes(markerIconBytes), // 이미지 바이트로부터 BitmapDescriptor 생성
    );

    // 기존 마커들과 함께 현재 위치를 나타내는 마커를 추가
    setState(() {
      markers.add(currentLocationMarker);
    });

  }

  _onPlaceChanges(String value) async {
    if (value.length < 10) return;

    _customInfoWindowController.hideInfoWindow!();
    final result = await LocationService.getPlacesAutoComplete(value);
    if (!result.success) {
      return;
    }
    final places = result.data as List<PredictionPlaceModel>;
    markers.clear();
    LatLng? latLng;
    double avgLat = 0;
    double avgLng = 0;

    for (var place in places) {
      LatLng latLng = LatLng(place.lat ?? 0, place.lng ?? 0);
      Marker marker = Marker(
          markerId: MarkerId(place.placeId.toString()),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          position: latLng,
          onTap: () {
            _customInfoWindowController.addInfoWindow!(
              CustomMarkerWindow(
                place: place,
                onViewDetails: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => PlaceDetailsView(place: place)),
                  );
                },
              ),
              latLng,
            );
          });
      markers.add(marker);
      avgLat += place.lat ?? 0;
      avgLng += place.lng ?? 0;
    }
    avgLat = avgLat / places.length;
    avgLng = avgLng / places.length;
    latLng = LatLng(avgLat, avgLng);
    final c = await _controller.future;

    c.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: 12)));
    setState(() {});
  }

  void _searchWord(String query) async {
    final result = await LocationService.getPlacesAutoComplete(query);

    if (result.success) {
      final places = result.data as List<PredictionPlaceModel>;
      markers.clear();
      if (places.isNotEmpty) {
        final place = places.first;
        final latLng = LatLng(place.lat ?? 0, place.lng ?? 0);
        final marker = Marker(
          markerId: MarkerId(place.placeId.toString()),
          position: latLng,
        );
        markers.add(marker);

        final c = await _controller.future;
        c.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: latLng, zoom: 15),
        ));
        setState(() {});
      }
    } else {
      print('Failed to fetch places: ${result.searchPlaceErrorMessage}');
      print(result.data);
    }
  }


  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;


    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        //fit: StackFit.expand,
        children: [
          //render map box
          GoogleMap(
            onTap: (position) {
              _customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position) {
              _customInfoWindowController.onCameraMove!();
            },
            markers: markers,
            myLocationEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              _customInfoWindowController.googleMapController = controller;
              _getCurrentPosition();
            },
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: MediaQuery.of(context).size.height * .15,
            width: MediaQuery.of(context).size.width * .75,
            offset: 50,
          ),
          Positioned(
            top: 30,
            left: 15,
            right: 15,
            child: Card(
              elevation: 2,
              color: Colors.white,
              child: TextFormField(
                onChanged: _onPlaceChanges,
                decoration: InputDecoration(
                  fillColor: Colors.transparent,
                  filled: true,
                  border: InputBorder.none,
                  hintText: "근처 지역을 검색하세요.",
                  prefixIcon: GestureDetector(
                    onTap: () {
                      _searchWord(_searchController.text);
                    },
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 24,
            left: 20,
            child: ElevatedButton(
              onPressed: () {
                _showNearbyPlacesBottomSheet(); // 아이콘 클릭 시 바텀 네비게이션 바 표시
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorWhite,
                minimumSize: Size(60, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: Icon(
                Icons.search,
                color: blueStyle_2,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: customBottomNavigationBar(selectedIndex, context),
    );
  }

  void _showNearbyPlacesBottomSheet() async {
    final currentLocation = await LocationService.getCurrentPosition();
    final distance = (await Geolocator.distanceBetween(
        currentLocation.latitude, currentLocation.longitude, 37.427961, -122.085749)) / 1000;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return MapBottomSheet();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      _searchWord(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _customInfoWindowController.dispose();
    super.dispose();
  }
}