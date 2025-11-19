// To parse this JSON data, do
//
//   final productEntry = ProductEntry.fromJson(responseMap);

import 'dart:convert';

ProductEntry productEntryFromJson(String str) =>
    ProductEntry.fromJson(json.decode(str));

String productEntryToJson(ProductEntry data) =>
    json.encode(data.toJson());

class ProductEntry {
    List<Item> items;

    ProductEntry({required this.items});

    factory ProductEntry.fromJson(Map<String, dynamic> json) => ProductEntry(
        items: List<Item>.from(
            (json["items"] as List).map((x) => Item.fromJson(x)),
        ),
    );

    Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
    };
}

class Item {
    String id;
    String name;
    int price;
    int? salePrice;
    String description;
    String category;          
    String? categoryDisplay; 
    bool isOnSale;
    bool isFeatured;
    String? thumbnail;
    int stock;
    String? brand;
    String? seller;

    Item({
        required this.id,
        required this.name,
        required this.price,
        this.salePrice,
        required this.description,
        required this.category,
        this.categoryDisplay,
        required this.isOnSale,
        required this.isFeatured,
        this.thumbnail,
        required this.stock,
        this.brand,
        this.seller,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"] as String,
        name: json["name"] as String,
        price: json["price"] as int,
        salePrice: json["sale_price"],
        description: json["description"] as String,
        category: json["category"] as String,
        categoryDisplay: json["category_display"],
        isOnSale: json["is_on_sale"] as bool,
        isFeatured: json["is_featured"] as bool,
        thumbnail: json["thumbnail"],
        stock: json["stock"] as int,
        brand: json["brand"],
        seller: json["seller"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "sale_price": salePrice,
        "description": description,
        "category": category,
        "category_display": categoryDisplay,
        "is_on_sale": isOnSale,
        "is_featured": isFeatured,
        "thumbnail": thumbnail,
        "stock": stock,
        "brand": brand,
        "seller": seller,
    };
}
