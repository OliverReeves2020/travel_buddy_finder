import 'dart:convert';

LoginValidator? LoginValidatorFromJson(String str) => LoginValidator.fromJson(json.decode(str));

String LoginValidatorToJson(LoginValidator? data) => json.encode(data!.toJson());

class LoginValidator {
  LoginValidator({
    this.match,
  });

  String? match;

  factory LoginValidator.fromJson(Map<String, dynamic> json) => LoginValidator(
    match: json["match"],
  );

  Map<String, dynamic> toJson() => {
    "match": match,
  };
}