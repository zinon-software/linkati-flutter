// To parse this JSON data, do
//
//     final authModel = authModelFromJson(jsonString);

import 'dart:convert';

AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel {
    AuthModel({
        this.token,
        this.id,
    });

    String? token;
    int? id;

    factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        token: json["token"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "id": id,
    };
}
