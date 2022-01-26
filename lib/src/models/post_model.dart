// To parse this JSON data, do
//
//     final posts = postsFromJson(jsonString);

import 'dart:convert';

List<Posts> postsFromJson(String str) => List<Posts>.from(json.decode(str).map((x) => Posts.fromJson(x)));

String postsToJson(List<Posts> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Posts {
    Posts({
        this.id,
        this.titel,
        this.link,
        this.message,
        this.dataType,
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
    String? message;
    String? dataType;
    bool? activation;
    DateTime? createdDt;
    int? views;
    CreatedBy? createdBy;
    Category? category;
    Category? sections;
    List<CreatedBy>? likes;

    factory Posts.fromJson(Map<String, dynamic> json) => Posts(
        id: json["id"],
        titel: json["titel"],
        link: json["link"],
        message: json["message"],
        dataType: json["data_type"],
        activation: json["activation"],
        createdDt: DateTime.parse(json["created_dt"]),
        views: json["views"],
        createdBy: CreatedBy.fromJson(json["created_by"]),
        category: json["category"] == null ? null :  Category.fromJson(json["category"]),
        sections: json["sections"] == null ? null :  Category.fromJson(json["sections"]),
        likes: List<CreatedBy>.from(json["likes"].map((x) => CreatedBy.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "titel": titel,
        "link": link,
        "message": message,
        "data_type": dataType,
        "activation": activation,
        "created_dt": createdDt?.toIso8601String(),
        "views": views,
        "created_by": createdBy?.toJson(),
        "category": category?.toJson(),
        "sections": sections?.toJson(),
        "likes": List<dynamic>.from(likes!.map((x) => x.toJson())),
    };
}

class Category {
    Category({
        this.id,
        this.name,
    });

    int? id;
    String? name;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

class CreatedBy {
    CreatedBy({
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
    String? name;
    String? avatar;
    String? description;
    int? posts;
    int? user;
    List<int>? follows;
    List<int>? followers;

    factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        id: json["id"],
        name: json["name"] == null ? null : json["name"],
        avatar: json["avatar"],
        description: json["description"] == null ? null : json["description"],
        posts: json["posts"],
        user: json["user"],
        follows: List<int>.from(json["follows"].map((x) => x)),
        followers: List<int>.from(json["followers"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name == null ? null : name,
        "avatar": avatar,
        "description": description == null ? null : description,
        "posts": posts,
        "user": user,
        "follows": List<dynamic>.from(follows!.map((x) => x)),
        "followers": List<dynamic>.from(followers!.map((x) => x)),
    };
}
