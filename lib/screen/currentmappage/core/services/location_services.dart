import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:planj_project/screen/currentmappage/core/config.dart';
import 'package:planj_project/screen/currentmappage/core/model/place_prediction_model.dart';
import 'package:planj_project/screen/currentmappage/core/services/http_service.dart';
import 'package:planj_project/screen/currentmappage/core/utils/network_response.dart';

class LocationService {
  static const apiKey = AppKeys.apiKey;
  static final httpService = HttpService();



  static Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  static Future<NetworkResponse> getPlacesAutoComplete(String place) async {
    final String url =
        "https://maps.googleapis.com/maps/api/place/textsearch/json?query=$place&radius=500&inputtype=textquery&language=ko&key=$apiKey&fields=formatted_address,name,geometry";
    log("url: $url");
    final response = await http.get(Uri.parse(url));
    print('API Request URL: $url');
    print('API Response Status Code: ${response.statusCode}');
    print('API Response Body: ${response.body}');


    final result = await httpService.get(url: url);
         if (result.success) {
           final data = result.data['results'] as List;

           List<PredictionPlaceModel> predictions = [];
           data
               .map((json) => predictions.add(PredictionPlaceModel.fromJson(json)))
               .toList();
           return NetworkResponse.success(
             data: predictions,
             message: result.message,
           );
         }
         return result;
  }
}