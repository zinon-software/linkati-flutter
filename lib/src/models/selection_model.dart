// To parse this JSON data, do
//
//     final selectionModel = selectionModelFromJson(jsonString);

import 'dart:convert';

List<SelectionModel> selectionModelFromJson(String str) => List<SelectionModel>.from(json.decode(str).map((x) => SelectionModel.fromJson(x)));

String selectionModelToJson(List<SelectionModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SelectionModel {
    SelectionModel({
        required this.id,
        required this.name,
    });

    int id;
    String name;

    factory SelectionModel.fromJson(Map<String, dynamic> json) => SelectionModel(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
