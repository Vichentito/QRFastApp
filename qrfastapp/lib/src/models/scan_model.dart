import 'dart:convert';
import 'package:meta/meta.dart';

ScanModel scanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));
String scanModelToJson(ScanModel data) => json.encode(data.toJson());

class ScanModel {
    ScanModel({
        @required this.id,
    });//Constructor
    int id;
    factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
    );
    Map<String, dynamic> toJson() => {
        "id": id,
    };
}
