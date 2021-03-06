import 'dart:convert';

import 'package:qrfastapp/src/models/productToBuy_model.dart';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
    String id;
    DateTime date;
    List<ProductToBuyModel> products;

    CartModel({
        this.id,
        this.date,
        this.products,
    });

    factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        date: DateTime.parse(json["date"]),
        products: List<ProductToBuyModel>.from(json["products"].map((x) => ProductToBuyModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
    };
}
