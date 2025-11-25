import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FoodItem {
  final String name;
  final double price;

  FoodItem({required this.name, required this.price});
}

class HotelModel {
  final String hotelName;
  final List<FoodItem> menu;

  HotelModel({required this.hotelName, required this.menu});
}

class FoodController extends GetxController {
  // Hotels with menus
  RxList<HotelModel> hotels = <HotelModel>[
    HotelModel(
      hotelName: "Hotel Taj Paradise",
      menu: [
        FoodItem(name: "Chicken Biryani", price: 180),
        FoodItem(name: "Paneer Butter Masala", price: 150),
        FoodItem(name: "Garlic Naan", price: 20),
      ],
    ),
    HotelModel(
      hotelName: "Green Garden Veg",
      menu: [
        FoodItem(name: "Veg Fried Rice", price: 120),
        FoodItem(name: "Gobi Manchurian", price: 90),
      ],
    ),
    HotelModel(
      hotelName: "KFC Express",
      menu: [
        FoodItem(name: "Zinger Burger", price: 160),
        FoodItem(name: "French Fries", price: 90),
      ],
    ),
  ].obs;

  // Cart
  RxList<FoodItem> cart = <FoodItem>[].obs;

  // Add item to cart
  void addToCart(FoodItem item) {
    cart.add(item);
    Get.snackbar("Added", "${item.name} added to cart");
  }

  // Confirm order & upload to Firestore
  Future<void> confirmOrder() async {
    try {
      final orderData = {
      "items": cart.map((item) => {
            "name": item.name,
            "price": item.price,
          }).toList(),
      "total": cart.fold(0.0, (sum, item) => sum + item.price),
      "timestamp": FieldValue.serverTimestamp(),
    };

      await FirebaseFirestore.instance.collection("orders").add(orderData);

      Get.snackbar("Success", "Order placed successfully!");
      cart.clear();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
