// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

loginModel welcomeFromJson(String str) => loginModel.fromJson(json.decode(str));

String welcomeToJson(loginModel data) => json.encode(data.toJson());

class loginModel {
    bool status;
    String message;
    String? token;

    loginModel({
        required this.status,
        required this.message,
        this.token,
    });

    factory loginModel.fromJson(Map<String, dynamic> json) => loginModel(
        status: json["status"],
        message: json["message"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "token": token,
    };
}
