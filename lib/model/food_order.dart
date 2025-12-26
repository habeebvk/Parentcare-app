class FoodOrder {
  final String id;
  final String name;
  final String storeName;
  final String dropLocation;
  final double total;
  final List<OrderItem> items;

  FoodOrder({
    required this.id,
    required this.name,
    required this.storeName,
    required this.dropLocation,
    required this.total,
    required this.items,
  });

  factory FoodOrder.fromJson(Map<String, dynamic> json) {
    return FoodOrder(
      id: json["_id"],
      name: json["name"],
      storeName: json["storeName"],
      dropLocation: json["dropLocation"],
      total: (json["total"] as num).toDouble(),
      items: (json["items"] as List)
          .map((e) => OrderItem.fromJson(e))
          .toList(),
    );
  }
}

class OrderItem {
  final String name;
  final double price;

  OrderItem({required this.name, required this.price});

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      name: json["name"],
      price: (json["price"] as num).toDouble(),
    );
  }
}
