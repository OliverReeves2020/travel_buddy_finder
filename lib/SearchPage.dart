import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import 'Objects/class.dart';
import 'Rest/ExpressClient.dart';
import 'Rest/SearchClient.dart';
import 'Rest/TripClient.dart';
final _formKey = GlobalKey<FormState>();
TextEditingController UserIDController = TextEditingController();
TextEditingController LocationController = TextEditingController();
TextEditingController TripNameController = TextEditingController();
TextEditingController WeatherController = TextEditingController();


class SearchPage extends StatefulWidget {
  SearchPage({Key? key, required this.user, required this.password})
      : super(key: key);
  final String user;
  final String password;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TripCollection Trips;
  var isLoaded = false;

  Object reload=Object();

  Future getAllTodos() async {
    try {
      if (UserIDController.text.isNotEmpty ||
          TripNameController.text.isNotEmpty ||
          LocationController.text.isNotEmpty ||
          WeatherController.text.isNotEmpty) {
      var a = new SearchClient();
      var response = await a.get("api", widget.user, widget.password,LocationController.text,WeatherController.text,
      TripNameController.text,UserIDController.text);
      print(response);
      print("length:");
      print(TripCollection
          .fromJson(json.decode(response))
          .trips
          .length
          .toString());
      Trips = TripCollection.fromJson(json.decode(response));
      return TripCollection
          .fromJson(json.decode(response))
          .trips;
    }
      //else{throw Error();}
    } catch (error) {
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        backgroundColor: Color.fromARGB(255, 139, 211, 221),
      ),
      body: Column(
        children: [
          //search bar form
          Form(
            key: _formKey,
            child: Column(
              children: [

                //location, String tripName, String userID, String weather
                TextFormField(
                  controller: LocationController,
                  decoration: InputDecoration(labelText: "Location"),
                  // The validator receives the text that the user has entered.
                ),
                TextFormField(
                  controller: UserIDController,
                  decoration: InputDecoration(labelText: "UserID"),
                  // The validator receives the text that the user has entered.
                ),
                TextFormField(
                  controller: TripNameController,
                  decoration: InputDecoration(labelText: "TripName"),
                  // The validator receives the text that the user has entered.
                ),
                TextFormField(
                  controller: WeatherController,
                  decoration: InputDecoration(labelText: "Weather"),
                  // The validator receives the text that the user has entered.
                ),
                ElevatedButton.icon(onPressed: (){
                  TripNameController.text;
                  //call search function
                  setState(() {
                    reload=Object();

                  });

                }, icon: Icon(Icons.search_rounded), label: Text("Search")),

              ],
            ),
          ),



          Flexible(child:
          FutureBuilder(
            key: ValueKey<Object>(reload),
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
          )
        ],
      ),


    );
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