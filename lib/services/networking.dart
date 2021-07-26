import 'dart:convert';

import 'package:http/http.dart' as Http;

class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

  Future getData() async {
    Http.Response response = await Http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode((response.body).toString());
    } else {
      print("Something went wrong");
    }
  }
}
