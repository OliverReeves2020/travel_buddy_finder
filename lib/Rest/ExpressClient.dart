
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:travel_buddy_finder/Objects/class.dart';

const String baseUrl='http://51.105.45.183:8080/Webapp-1.0-SNAPSHOT';

class ExpressClient
{
  var client= http.Client();
  Future<dynamic> get(String api,String userId,String passKey)  async{

    var headers = {
      'userID': userId,
      'passKey': passKey,
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse('http://51.105.45.183:8080/Webapp-1.0-SNAPSHOT/Express'));
    request.body = json.encode({
      "userID": userId
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    }
    else {
      print(response.reasonPhrase);
      throw"error";
    }



  }
  Future<String> put(String api,String userId,String passKey,String tripId)  async{

    //var url=Uri.parse(baseUrl);
    var headers = {
      'userID': userId,
      'PassKey': passKey,
      'Content-Type': 'application/json'
    };
    var request = http.Request('PUT', Uri.parse('http://51.105.45.183:8080/Webapp-1.0-SNAPSHOT/Express'));
    request.body = json.encode({
      "tripID": tripId
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      return "expressed";

      //return s;
      //jsonDecode(s)
      //return s;


    }
    else {
      print("not found");
      return "error";
    }


  }
  Future<dynamic> post(String api)async{}
  Future<dynamic> delete(String api)async{}
}