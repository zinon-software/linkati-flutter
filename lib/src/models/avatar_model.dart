// To parse this JSON data, do
//
//     final avatarModel = avatarModelFromJson(jsonString);

import 'dart:convert';

List<AvatarModel> avatarModelFromJson(String str) => List<AvatarModel>.from(json.decode(str).map((x) => AvatarModel.fromJson(x)));

String avatarModelToJson(List<AvatarModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AvatarModel {
    AvatarModel({
        required this.id,
        required this.avatar,
    });

    int id;
    String avatar;

    factory AvatarModel.fromJson(Map<String, dynamic> json) => AvatarModel(
        id: json["id"],
        avatar: json["avatar"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "avatar": avatar,
    };
}
