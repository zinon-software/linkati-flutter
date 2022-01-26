// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

List<Users> usersFromJson(String str) => List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String usersToJson(List<Users> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
    Users({
        required this.id,
        required this.name,
        required this.avatar,
        required this.description,
        required this.posts,
        required this.user,
        required this.follows,
        required this.followers,
    });

    int id;
    dynamic name;
    String avatar;
    dynamic description;
    int posts;
    User user;
    List<User> follows;
    List<User> followers;

    factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"],
        name: json["name"],
        avatar: json["avatar"],
        description: json["description"],
        posts: json["posts"],
        user: User.fromJson(json["user"]),
        follows: List<User>.from(json["follows"].map((x) => User.fromJson(x))),
        followers: List<User>.from(json["followers"].map((x) => User.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar,
        "description": description,
        "posts": posts,
        "user": user.toJson(),
        "follows": List<dynamic>.from(follows.map((x) => x.toJson())),
        "followers": List<dynamic>.from(followers.map((x) => x.toJson())),
    };
}

class User {
    User({
        required this.id,
        required this.password,
        required this.email,
        required this.username,
        required this.dateJoined,
        required this.lastLogin,
        required this.isAdmin,
        required this.isActive,
        required this.isStaff,
        required this.isSuperuser,
    });

    int id;
    String password;
    String email;
    String username;
    DateTime dateJoined;
    DateTime lastLogin;
    bool isAdmin;
    bool isActive;
    bool isStaff;
    bool isSuperuser;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        password: json["password"],
        email: json["email"],
        username: json["username"],
        dateJoined: DateTime.parse(json["date_joined"]),
        lastLogin: DateTime.parse(json["last_login"]),
        isAdmin: json["is_admin"],
        isActive: json["is_active"],
        isStaff: json["is_staff"],
        isSuperuser: json["is_superuser"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "password": password,
        "email": email,
        "username": username,
        "date_joined": dateJoined.toIso8601String(),
        "last_login": lastLogin.toIso8601String(),
        "is_admin": isAdmin,
        "is_active": isActive,
        "is_staff": isStaff,
        "is_superuser": isSuperuser,
    };
}
