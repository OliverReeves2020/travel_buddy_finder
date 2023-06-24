import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:like_button/like_button.dart';
import 'package:travel_buddy_finder/Forms/TripCreation.dart';
import 'package:travel_buddy_finder/Objects/class.dart';

import 'Objects/ExpressedTrips.dart';
import 'Rest/ExpressClient.dart';

class InterestPage extends StatefulWidget {
  InterestPage({Key? key, required this.user, required this.password})
      : super(key: key);
  final String user;
  final String password;


  @override
  State<InterestPage> createState() => _InterestPageState();
}

class _InterestPageState extends State<InterestPage> {

  late TripExpression Trips;
  var isLoaded = false;

  Future getAllTodos() async {
    try {
      var a = new ExpressClient();
      var response = await a.get("api", widget.user, widget.password);
      print(response);
      print("length:");
      print(TripExpression.fromJson(json.decode(response))
          .trips.length
          .toString());
      Trips = TripExpression.fromJson(json.decode(response));
      return TripExpression.fromJson(json.decode(response)).trips;
    } catch (error) {
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 139, 211, 221),
        title: Text("Interests"),
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          // WHILE THE CALL IS BEING MADE AKA LOADING
          if (ConnectionState.active != null && !snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          // WHEN THE CALL IS DONE BUT HAPPENS TO HAVE AN ERROR
          if (ConnectionState.done != null && snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          // IF IT WORKS IT GOES HERE!
          return ListView.separated(
            padding: EdgeInsets.all(10),
            itemCount: Trips.trips.length,
            itemBuilder: (context, index) {
              return Container(
                  color: Color.fromARGB(255, 243, 210, 193),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(Trips.trips[index].tripId.toString()),
                      ),
                      ListTile(
                        title: Text(Trips.trips[index].interest.toString()),
                      ),
                      ListTile(
                        title: Text(Trips.trips[index].interestamount.toString()),
                      ),



                    ],
                  ));

              return ListTile(
                title: Text(Trips.trips[index].tripId),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                indent: 20,
                endIndent: 20,
              );
            },
          );
        },
        future: getAllTodos(),
      ),

    );
  }


}


