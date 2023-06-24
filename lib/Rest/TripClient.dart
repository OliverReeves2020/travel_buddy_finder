
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:travel_buddy_finder/Objects/class.dart';

const String baseUrl='http://localhost:8080/Webapp/trip';

class TripClient
{
  var client=http.Client();

  Future<dynamic> get(String api,String userId,String passKey)  async{

    //var url=Uri.parse(baseUrl);
    var headers = {
      'userID': userId,
      'passKey': passKey,
      'Connection':'keep-alive'
    };
    var request = http.Request('GET', Uri.parse('http://51.105.45.183:8080/Webapp-1.0-SNAPSHOT/trip'));
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

  Future<dynamic> post(String userId,String passKey,String tripname,String location,String date)async{


    print(date);

    var headers = {
      'UserID': userId,
      'passKey': passKey,
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('http://51.105.45.183:8080/Webapp-1.0-SNAPSHOT/trip'));
    request.body = json.encode({
      "tripname": tripname,
      "location": location,
      "date": date
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("created");
      return "created";

    }
    else {
      return "error";
    }

  }

  Future<dynamic> put(String Tripid,String userId,String passKey,String tripname,String location,String date)async{

    var headers = {
      'userID': userId,
      'passKey': passKey,
      'Content-Type': 'application/json'
    };
    var request = http.Request('PUT', Uri.parse('http://51.105.45.183:8080/Webapp-1.0-SNAPSHOT/trip'));


    Map<String, dynamic> jsonData=new Map();
    jsonData["tripID"]=Tripid;
    if(tripname.isNotEmpty){jsonData["tripname"]=tripname.toString();}
    if(date.isNotEmpty){jsonData["date"]=date;}
    if(location.isNotEmpty){jsonData["location"]=location.toString();}

    print(JsonEncoder().convert(jsonData));
    request.body = JsonEncoder().convert(jsonData);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("update");
      return "created";
    }
    else {
      return "error";
    }




  }
  Future<dynamic> delete(String userID,String passKey,String tripID)async{
    var headers = {
      'userID': userID,
      'passkey': passKey,
      'Content-Type': 'application/json'
    };
    var request = http.Request('DELETE', Uri.parse('http://51.105.45.183:8080/Webapp-1.0-SNAPSHOT/trip'));
    request.body = json.encode({
      "tripID": tripID
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("deleted");

      //TripCollection.fromJson(s);
      //
      return "deleted";
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