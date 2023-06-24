import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:travel_buddy_finder/Rest/UserClient.dart';

import 'Forms/TripUpdate.dart';
import 'Objects/class.dart';
import 'Rest/ExpressClient.dart';
import 'Rest/TripClient.dart';

class Profile extends StatefulWidget {
  Profile({Key? key, required this.user, required this.password})
      : super(key: key);
  final String user;
  final String password;
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late TripCollection Trips;
  var isLoaded = false;


  Future getAllTodos() async {
    try {
      var a = new UserClient();
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
        title: Text("My Posts"),
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
                        title: Text(Trips.trips[index].tripName),
                      ),
                      ListTile(
                        title: Text(Trips.trips[index].date),
                      ),
                      ListTile(
                        title: Text(Trips.trips[index].weather),
                      ),
                      Row(
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton.icon(onPressed: (){
                            showDataAlert(widget.user,widget.password,Trips.trips[index].tripId);
                          },
                            label: Text("Edit"),
                            icon: Icon(Icons.edit),),
                          ElevatedButton.icon(onPressed: (){
                            var resp=new TripClient().delete(widget.user, widget.password, Trips.trips[index].tripId);
                            if (resp=="deleted");{
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(

                                  content: const Text("Trip has been deleted"),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                      child: Container(
                                        color: Colors.green,
                                        padding: const EdgeInsets.all(14),
                                        child: const Text("okay"),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                            label: Text("Delete"),
                            icon: Icon(Icons.delete),
                          ),

                        ],
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
  showDataAlert(String user,String password,tripId) {
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
            title: Text("update"+tripId),
            content: new UpdateTripForm(user:user, password: password,tripId:tripId),
          );
        });
  }
}


