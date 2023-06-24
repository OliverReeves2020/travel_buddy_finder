import 'dart:convert';
import 'dart:async';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:like_button/like_button.dart';
import 'package:travel_buddy_finder/Forms/TripCreation.dart';
import 'package:travel_buddy_finder/Objects/class.dart';

import 'Rabbit/Rabbitmq.dart';
import 'Rest/ExpressClient.dart';
import 'Rest/TripClient.dart';
import 'package:dart_amqp/dart_amqp.dart';


class FeedPage extends StatefulWidget {
  FeedPage({Key? key, required this.user, required this.password})
      : super(key: key);
  final String user;
  final String password;

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  late TripCollection Trips;
  var isLoaded = false;


  Future getAllTodos() async {
    try {
      var a = new TripClient();
      var response = await a.get("api", widget.user, widget.password);
      print(response);
      print("length:");
      print(TripCollection.fromJson(json.decode(response))
          .trips
          .length
          .toString());
      Trips = TripCollection.fromJson(json.decode(response));
      return TripCollection.fromJson(json.decode(response)).trips;
    } catch (error) {
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 139, 211, 221),
        title: Text("Feed"),
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
                        title: Text(Trips.trips[index].tripId),
                      ),
                      ListTile(
                        title: Text(Trips.trips[index].userId),
                      ),
                      ListTile(
                        title: Text(Trips.trips[index].tripName),
                      ),
                      ListTile(
                        title: Text(Trips.trips[index].date),
                      ),
                      ListTile(
                        title: Text(Trips.trips[index].weather),
                      ),
                      LikeButton(
                        onTap: (isLiked) {
                          return onLikeButtonTapped(isLiked, widget.user,
                              widget.password, Trips.trips[index].tripId);
                        },
                        isLiked:
                            (Trips.trips[index].interest.contains(widget.user)
                                ? true
                                : false),
                        size: 50,
                        circleColor: CircleColor(
                            start: Color(0xff00ddff), end: Colors.black),
                        bubblesColor: BubblesColor(
                          dotPrimaryColor: Color(0xff33b5e5),
                          dotSecondaryColor: Color(0xff0099cc),
                        ),
                        likeBuilder: (bool isLiked) {
                          return Icon(
                            Icons.favorite,
                            color: isLiked
                                ? (Color.fromARGB(255, 245, 130, 174))
                                : (Color.fromARGB(255, 139, 211, 221)),
                            size: 50,
                          );
                        },
                        likeCount: Trips.trips[index].interestamount,
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
      floatingActionButton: FloatingActionButton(child: Icon(Icons.mode_of_travel_outlined),
        onPressed: () {showDataAlert(widget.user,widget.password);},
      ),
    );
  }

  showDataAlert(String user,String password) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  20.0,
                ),
              ),
            ),
            contentPadding: EdgeInsets.only(
              top: 10,
            ),
            title: Text("Create Trip"),
            content: CreateTripForm(user:user, password: password),
          );
        });
  }
}

Future<bool> onLikeButtonTapped(
    bool isLiked, String user, String password, String tripId) async {
  /// send your request here
  // final bool success= await sendRequest();
  //send update to rest api then reload state

  print('like tapped:' + tripId);

  var res = await new ExpressClient().put("api", user, password, tripId);
  if (res == "expressed") {
    return !isLiked;
  }

  /// if failed, you can do nothing
  // return success? !isLiked:isLiked;
  return isLiked;
}
