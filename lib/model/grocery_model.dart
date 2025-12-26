import 'package:parent_care/model/grocery_item.dart';

class GroceryOrderModel {
  final String name;
  final String dropLocation;
  final double? latitude;
  final double? longitude;
  final String storeName;
  final List<GroceryItemModel> items;
  final double totalAmount;
  final bool homeDelivery;

  GroceryOrderModel({
    required this.name,
    required this.dropLocation,
    this.latitude,
    this.longitude,
    required this.storeName,
    required this.items,
    required this.totalAmount,
    required this.homeDelivery,
  });

  /// SEND → BACKEND
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "drop_location": dropLocation,
      "latitude": latitude,
      "longitude": longitude,
      "store_name": storeName,
      "items": items.map((e) => e.toJson()).toList(),
      "total_price": totalAmount,
      "home_delivery": homeDelivery,
    };
  }

  /// RECEIVE ← BACKEND (NULL SAFE)
factory GroceryOrderModel.fromJson(Map<String, dynamic> json) {
  return GroceryOrderModel(
    name: json["name"] ?? "",
    dropLocation: json["dropLocation"] ?? "",       // camelCase
    latitude: (json["latitude"] as num?)?.toDouble(),
    longitude: (json["longitude"] as num?)?.toDouble(),
    storeName: json["storeName"] ?? "",
    items: (json["items"] as List? ?? [])
        .map((e) => GroceryItemModel.fromJson(e))
        .toList(),
    totalAmount: (json["totalAmount"] as num?)?.toDouble() ?? 0.0,  // camelCase
    homeDelivery: json["homeDelivery"] ?? false,
  );
}

}
