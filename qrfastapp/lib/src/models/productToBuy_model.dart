import 'dart:convert';

ProductToBuyModel productToBuyModelFromJson(String str) => ProductToBuyModel.fromJson(json.decode(str));

String productToBuyModelToJson(ProductToBuyModel data) => json.encode(data.toJson());

class ProductToBuyModel {
    String id;
    int idProduct;
    String name;
    String description;
    double price;
    String image;
    int quantity;

    ProductToBuyModel({
        this.id,
        this.idProduct=0,
        this.name = '',
        this.description = '',
        this.price = 0.0,
        this.image,
        this.quantity = 1
    });

    factory ProductToBuyModel.fromJson(Map<String, dynamic> json) => ProductToBuyModel(
        id: json["id"],
        idProduct: json["idProduct"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        image: json["image"],
        quantity: json["quantity"],
    );

    Map<String, dynamic> toJson() => {
        "idProduct": idProduct,
        "name": name,
        "description": description,
        "price": price,
        "image": image,
        "quantity": quantity
    };
}
