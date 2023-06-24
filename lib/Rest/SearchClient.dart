import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:travel_buddy_finder/Objects/class.dart';

const String baseUrl='http://localhost:8080/Webapp/trip';

class SearchClient {
  var client = http.Client();

  Future<dynamic> get(String api, String userId, String passKey,String Location,String Weather,String tripName,
      String tripuser) async {
    //var url=Uri.parse(baseUrl);
    var headers = {
      'userID': userId,
      'passKey': passKey,
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse('http://51.105.45.183:8080/Webapp-1.0-SNAPSHOT/trip'));

    Map<String, dynamic> jsonData=new Map();
    if(Location.isNotEmpty){jsonData["location"]=Location.toString();}
    if(Weather.isNotEmpty){jsonData["weather"]=Weather.toString();}
    if(tripName.isNotEmpty){jsonData["tripName"]=tripName.toString();}
    if(tripuser.isNotEmpty){jsonData["userID"]=tripuser.toString();}
    print(JsonEncoder().convert(jsonData));
    request.body = JsonEncoder().convert(jsonData);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    //var response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      var s = response.stream.bytesToString();
      //TripCollection.fromJson(s);
      //
      return s;
      //return s;
      //jsonDecode(s)
      //return s;


    }
    else {
      print("not found");
      throw "error  ";
    }
  }

}