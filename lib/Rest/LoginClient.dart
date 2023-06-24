import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:travel_buddy_finder/Objects/class.dart';

const String baseUrl='http://localhost:8080/Webapp/trip';

class LoginClient
{
  var client=http.Client();

  Future<dynamic> get(String userId,String passKey)  async{

    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse('http://51.105.45.183:8080/Webapp-1.0-SNAPSHOT/Login'));
    request.body = json.encode({
      "userID": userId,
      "passKey": passKey,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {

      var s=response.stream.bytesToString();
      //TripCollection.fromJson(s);
      //
      return s;
      //return s;
      //jsonDecode(s)
      //return s;


    }
    else {
    print("not found");
    return "error";
    }

  }
  Future<dynamic> put(String userId,String passKey) async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('http://51.105.45.183:8080/Webapp-1.0-SNAPSHOT/Login'));
    request.body = json.encode({
      "userID": userId,
      "passKey": passKey
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      var s=response.stream.bytesToString();
      return s;
    }
    else {
      return "error";
    }
  }

}