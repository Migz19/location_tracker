import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:location_tracker/core/app_constants.dart';

import '../local/model/location/place.dart';

class SearchHelper {
  Future<List<Place>> searchHereMaps(String query) async {

    final response = await http.get(Uri.parse(AppConstants.requestUrl(query)));

    if (response.statusCode == StatusCode.OK) {
      final jsonResponse = json.decode(utf8.decode(response.bodyBytes));

      if (jsonResponse['items'].isNotEmpty) {

        final places = jsonResponse['items']
            .where((item) => item['address']['countryCode'] == 'EGY')
            .map<Place>((item) {
          return Place.fromJson(item);
        }).toList();

        return places;
      } else {
        throw Exception('No results found');
      }
    } else {
      throw Exception('Failed to load search results: ${response.statusCode}');
    }
  }
}
