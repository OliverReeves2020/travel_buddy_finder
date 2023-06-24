
import 'dart:convert';







  TripCollection welcomeFromJson(String str) => TripCollection.fromJson(json.decode(str));

  String welcomeToJson(TripCollection data) => json.encode(data.toJson());

  class TripCollection {
  TripCollection({
   required this.trips,
  });

  List<Trip> trips;

  factory TripCollection.fromJson(Map<String, dynamic> json) => TripCollection(
  trips: List<Trip>.from(json["trips"].map((x) => Trip.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
  "trips": trips !=null ? List<dynamic>.from(trips!.map((x) => x.toJson())):[],
  };
  }

  class Trip {
  Trip({
  required this.tripName,
  required this.location,
  required this.userId,
  required this.weather,
  required this.date,
  required this.interestamount,
  required this.interest,
  required this.tripId,
  });

  String tripName;
  String location;
  String userId;
  String weather;
  String date;
  int interestamount;
  List<String> interest;
  String tripId;

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
  tripName: json["tripName"],
  location: json["location"],
  userId: json["userID"],
  weather: json["weather"],
  date: json["date"],
  interestamount: json["interestamount"],
  interest: List<String>.from(json["interest"].map((x) => x)),
  tripId: json["tripID"],
  );

  Map<String, dynamic> toJson() => {
  "tripName": tripName,
  "location": location,
  "userID": userId,
  "weather": weather,
  "date": date,
  "interestamount": interestamount,
  "interest": List<dynamic>.from(interest.map((x) => x)),
  "tripID": tripId,
  };
  }
