class GroceryItemModel {
  final String name;
  final int price;
  final int quantity;

  GroceryItemModel({
    required this.name,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "price": price,
      "quantity": quantity,
    };
  }

  factory GroceryItemModel.fromJson(Map<String, dynamic> json) {
    return GroceryItemModel(
      name: json['name'] ?? "",
      price: json['price'] ?? 0,
      quantity: json['quantity'] ?? 0,
    );
  }
}
