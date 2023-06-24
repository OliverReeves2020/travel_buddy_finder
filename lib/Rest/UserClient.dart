import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:travel_buddy_finder/Objects/class.dart';

const String baseUrl='http://localhost:8080/Webapp/trip';

class UserClient
{
  var client=http.Client();

  Future<dynamic> get(String api,String userId,String passKey)  async{

    //var url=Uri.parse(baseUrl);
    var headers = {
      'userID': userId,
      'passKey': passKey,
      'Connection':'keep-alive'
    };
    var request = http.Request('GET', Uri.parse('http://51.105.45.183:8080/Webapp-1.0-SNAPSHOT/UserTripServlet'));
    //request.body = json.encode({
    //"location": "London, Greater London, England, SW1A 2DX, United Kingdom"
    //});

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    //var response = await request.send();
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
      throw "error  ";
    }


  }


}