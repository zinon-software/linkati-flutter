// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

List<NotificationModel> notificationModelFromJson(String str) => List<NotificationModel>.from(json.decode(str).map((x) => NotificationModel.fromJson(x)));

String notificationModelToJson(List<NotificationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationModel {
    NotificationModel({
        this.id,
        this.action,
        this.read,
        this.createdDt,
        this.sender,
        this.receiver,
        this.post,
    });

    int? id;
    String? action;
    bool? read;
    DateTime? createdDt;
    Receiver? sender;
    Receiver? receiver;
    Post? post;

    factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        id: json["id"],
        action: json["action"],
        read: json["read"],
        createdDt: DateTime.parse(json["created_dt"]),
        sender: Receiver.fromJson(json["sender"]),
        receiver: Receiver.fromJson(json["receiver"]),
        post: json["post"] == null ? null : Post.fromJson(json["post"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "action": action,
        "read": read,
        "created_dt": createdDt!.toIso8601String(),
        "sender": sender!.toJson(),
        "receiver": receiver!.toJson(),
        "post": post == null ? null : post!.toJson(),
    };
}

class Post {
    Post({
        this.id,
        this.titel,
        this.link,
        this.activation,
        this.createdDt,
        this.views,
        this.createdBy,
        this.category,
        this.sections,
        this.likes,
    });

    int? id;
    String? titel;
    String? link;
    bool? activation;
    DateTime? createdDt;
    int? views;
    int? createdBy;
    int? category;
    int? sections;
    List<dynamic>? likes;

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        titel: json["titel"],
        link: json["link"],
        activation: json["activation"],
        createdDt: DateTime.parse(json["created_dt"]),
        views: json["views"],
        createdBy: json["created_by"],
        category: json["category"],
        sections: json["sections"],
        likes: List<dynamic>.from(json["likes"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "titel": titel,
        "link": link,
        "activation": activation,
        "created_dt": createdDt!.toIso8601String(),
        "views": views,
        "created_by": createdBy,
        "category": category,
        "sections": sections,
        "likes": List<dynamic>.from(likes!.map((x) => x)),
    };
}

class Receiver {
    Receiver({
        this.id,
        this.name,
        this.avatar,
        this.description,
        this.posts,
        this.user,
        this.follows,
        this.followers,
    });

    int? id;
    dynamic name;
    String? avatar;
    dynamic description;
    int? posts;
    int? user;
    List<int>? follows;
    List<dynamic>? followers;

    factory Receiver.fromJson(Map<String, dynamic> json) => Receiver(
        id: json["id"],
        name: json["name"],
        avatar: json["avatar"],
        description: json["description"],
        posts: json["posts"],
        user: json["user"],
        follows: List<int>.from(json["follows"].map((x) => x)),
        followers: List<dynamic>.from(json["followers"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar,
        "description": description,
        "posts": posts,
        "user": user,
        "follows": List<dynamic>.from(follows!.map((x) => x)),
        "followers": List<dynamic>.from(followers!.map((x) => x)),
    };
}
