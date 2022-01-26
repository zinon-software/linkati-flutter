
// To parse this JSON data, do
//
//     final userInfoModel = userInfoModelFromJson(jsonString);

import 'dart:convert';

UserInfoModel userInfoModelFromJson(String str) => UserInfoModel.fromJson(json.decode(str));

String userInfoModelToJson(UserInfoModel data) => json.encode(data.toJson());

class UserInfoModel {
    UserInfoModel({
        this.isFollowing,
        this.postCount,
        this.follows,
        this.followers,
        this.name,
        this.id,
        this.username,
        this.isAdmin,
        this.bio,
        this.avatar,
    });

    bool? isFollowing;
    int? postCount;
    int? follows;
    int? followers;
    dynamic? name;
    int? id;
    String? username;
    bool? isAdmin;
    dynamic? bio;
    String? avatar;

    factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
        isFollowing: json["isFollowing"],
        postCount: json["post_count"],
        follows: json["follows"],
        followers: json["followers"],
        name: json["name"],
        id: json["id"],
        username: json["username"],
        isAdmin: json["is_admin"],
        bio: json["bio"],
        avatar: json["avatar"],
    );

    Map<String, dynamic> toJson() => {
        "isFollowing": isFollowing,
        "post_count": postCount,
        "follows": follows,
        "followers": followers,
        "name": name,
        "id": id,
        "username": username,
        "is_admin": isAdmin,
        "bio": bio,
        "avatar": avatar,
    };
}
