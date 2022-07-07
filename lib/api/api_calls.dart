// Documentation : https://beanboi7.github.io/yomomma-apiv2/#/readme
import 'dart:convert';

import 'package:http/http.dart' as http;

// API calling limit : 5 calls/minute
// to check this, use shared prefs to store count and list of time
// After 5 API calls, if the difference between time[0] and time[4] is less than 1 minute : no API call for another minute
// After 5 API calls, if the difference between time[0] and time[4] is more than 1 minute : reset count and time
class Api {
  final String apiLink = 'https://yomomma-api.herokuapp.com/';

  Future<List<dynamic>> getRandomJoke(int count) async {
    // Count range : 1 to 500

    String link = '${apiLink}jokes?count=$count';
    http.Response response = await http.get(Uri.parse(link));

    String result = response.body.toString();
    if (result[0] != '[') {
      result = '[$result]';
    }

    List<Map<String, dynamic>> jsonList =
        List<Map<String, dynamic>>.from(json.decode(result));

    List<dynamic> output = [];

    for (var joke in jsonList) {
      output.add(joke['joke']);
    }

    return output;
  }

  Future<List<dynamic>> getSearchedJoke(String searchText) async {
    String link = '${apiLink}search?query=$searchText';

    http.Response response = await http.get(Uri.parse(link));

    Map<String, List<dynamic>> jsonList =
        Map<String, List<dynamic>>.from(json.decode(response.body));

    return jsonList['results']!;
  }
}
