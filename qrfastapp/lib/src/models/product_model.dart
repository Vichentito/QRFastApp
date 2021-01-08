import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
    static final int max = 1000;
    String id;
    int idProduct;
    String name;
    String description;
    double price;
    String image;

    ProductModel({
        this.id,
        this.idProduct,
        this.name = '',
        this.description = '',
        this.price = 0.0,
        this.image
    });

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        idProduct: json["idProduct"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "idProduct": idProduct,
        "name": name,
        "description": description,
        "price": price,
        "image": image
    };
}
