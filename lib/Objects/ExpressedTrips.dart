// To parse this JSON data, do
//
//     final tripExpression = tripExpressionFromJson(jsonString);

import 'dart:convert';


TripExpression tripExpressionFromJson(String str) => TripExpression.fromJson(json.decode(str));

String tripExpressionToJson(TripExpression? data) => json.encode(data!.toJson());

class TripExpression {
  TripExpression({
    required this.trips,
  });

  List<Trip> trips;

  factory TripExpression.fromJson(Map<String, dynamic> json) => TripExpression(
    trips: List<Trip>.from(json["trips"].map((x) => Trip.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "trips": trips !=null ? List<dynamic>.from(trips!.map((x) => x.toJson())):[],
  };
}

class Trip {
  Trip({
    required this.interestamount,
    required this.interest,
    required this.tripId,
  });

  int interestamount;
  List<String> interest;
  String tripId;

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
    interestamount: json["interestamount"],
    interest: List<String>.from(json["interest"].map((x) => x)),
    tripId: json["tripID"],
  );

  Map<String, dynamic> toJson() => {
    "interestamount": interestamount,
    "interest": List<dynamic>.from(interest.map((x) => x)),
    "tripID": tripId,
  };
}
