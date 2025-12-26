import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:parent_care/model/food_order.dart';
import 'package:parent_care/services/api_service.dart';

/// ---------------- Models ----------------



class HotelModel {
  final String hotelName;
  final List<OrderItem> menu;

  HotelModel({required this.hotelName, required this.menu});
}

/// ---------------- Controller ----------------

class FoodController extends GetxController {
  // -------- Hotels --------
  RxList<HotelModel> hotels = <HotelModel>[
    HotelModel(
      hotelName: "Hotel Taj Paradise",
      menu: [
        OrderItem(name: "Chicken Biryani", price: 180),
        OrderItem(name: "Paneer Butter Masala", price: 150),
        OrderItem(name: "Garlic Naan", price: 20),
      ],
    ),
    HotelModel(
      hotelName: "Green Garden Veg",
      menu: [
        OrderItem(name: "Veg Fried Rice", price: 120),
        OrderItem(name: "Gobi Manchurian", price: 90),
      ],
    ),
    HotelModel(
      hotelName: "KFC Express",
      menu: [
        OrderItem(name: "Zinger Burger", price: 160),
        OrderItem(name: "French Fries", price: 90),
      ],
    ),
  ].obs;

  // -------- Cart --------
  RxList<OrderItem> cart = <OrderItem>[].obs;
  RxString selectedStore = "".obs;


  // -------- User Inputs --------
  final nameController = TextEditingController();
  final dropController = TextEditingController();
  final dropFocus = FocusNode();

  double? dropLat;
  double? dropLng;

  // -------- Add to Cart --------
  void addToCart(OrderItem item, String storeName) {
  if (selectedStore.isNotEmpty && selectedStore.value != storeName) {
    Get.snackbar(
      "Error",
      "You can order from only one store at a time",
      snackPosition: SnackPosition.TOP,
    );
    return;
  }

  if (selectedStore.isEmpty) {
    selectedStore.value = storeName; // ✅ lock store
  }

  cart.add(item);
  Get.snackbar("Added", "${item.name} added to cart");
}


  // -------- Total --------
  double get total =>
      cart.fold(0.0, (sum, item) => sum + item.price);

  // -------- Confirm Order --------
Future<void> confirmOrder() async {
  if (nameController.text.isEmpty ||
      dropController.text.isEmpty ||
      cart.isEmpty) {
    Get.snackbar("Error", "Please complete all fields");
    return;
  }

    final orderData = {
      "name": nameController.text.trim(),
      "storeName": selectedStore.value, // ✅ REQUIRED
      "dropLocation": dropController.text.trim(),
      "latitude": dropLat ?? 0.0,
      "longitude": dropLng ?? 0.0,
      "items": cart.map((item) => {
            "name": item.name,
            "price": item.price,
          }).toList(),
      "total": total,
    };


  try {
    await ApiService.placeFoodOrder(orderData);

    Get.snackbar("Success", "Order placed successfully");

    cart.clear();
    selectedStore.value= "";
    nameController.clear();
    dropController.clear();
  } catch (e) {
    Get.snackbar("Error", e.toString());
  }
}

  @override
  void onClose() {
    nameController.dispose();
    dropController.dispose();
    dropFocus.dispose();
    super.onClose();
  }
}

class FoodOrdersController extends GetxController {
  RxList<FoodOrder> orders = <FoodOrder>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    fetchOrders();
    super.onInit();
  }

  Future<void> fetchOrders() async {
    try {
      isLoading(true);
      orders.value = await ApiService.fetchFoodOrders();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
