import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parent_care/controllers/item_controller.dart';
import '../model/store_model.dart';
import '../model/grocery_item.dart';
import '../services/api_service.dart';

class GroceryController extends GetxController {
  // ---------------- Stores & Cart ----------------
  RxList<StoreModel> stores = <StoreModel>[
    StoreModel(
      id: "1",
      name: "Fresh Mart",
      image: "assets/curd-premium.png",
      items: [
        GroceryItem(id: "i1", name: "Tomatoes", price: 30),
        GroceryItem(id: "i2", name: "Onions", price: 40),
        GroceryItem(id: "i3", name: "Garlic", price: 35),
      ],
    ),
    StoreModel(
      id: "2",
      name: "Green Basket",
      image: "assets/paneer-lite.png",
      items: [
        GroceryItem(id: "i4", name: "Bananas", price: 50),
        GroceryItem(id: "i5", name: "Bread", price: 35),
      ],
    ),
  ].obs;

  Rx<StoreModel?> selectedStore = Rx<StoreModel?>(null);
  RxMap<String, int> cart = <String, int>{}.obs;
  RxBool homeDelivery = false.obs;

  // ---------------- Customer input ----------------
  final nameController = TextEditingController();
  final dropController = TextEditingController();
  final dropFocus = FocusNode();
  double? dropLat;
  double? dropLng;

  // ---------------- Orders ----------------
  RxBool isLoading = false.obs;
  RxList<dynamic> orders = <dynamic>[].obs;

  // ---------------- Init ----------------
  @override
  void onInit() {
    super.onInit();
    fetchOrders(); // fetch orders from MongoDB/API
  }

  // ---------------- Store Selection ----------------
  void selectStore(StoreModel store) {
    selectedStore.value = store;
    cart.clear();
  }

  // ---------------- Add to Cart ----------------
  void addToCart(GroceryItem item) {
    cart[item.id] = (cart[item.id] ?? 0) + 1;
  }

  // ---------------- Total Price ----------------
  double get total {
    double sum = 0;
    cart.forEach((itemId, qty) {
      final item = selectedStore.value!.items.firstWhere((e) => e.id == itemId);
      sum += item.price * qty;
    });
    if (homeDelivery.value) sum += 20;
    return sum;
  }

  // ---------------- Confirm Order ----------------
  Future<void> confirmOrder() async {
    if (selectedStore.value == null ||
        cart.isEmpty ||
        nameController.text.isEmpty ||
        dropController.text.isEmpty) {
      Get.snackbar("Error", "Complete all fields");
      return;
    }

    final items = cart.entries.map((entry) {
      final item = selectedStore.value!.items.firstWhere((e) => e.id == entry.key);
      return {
        "id": item.id,
        "name": item.name,
        "price": item.price,
        "quantity": entry.value,
        "total": item.price * entry.value,
      };
    }).toList();

    final orderData = {
      "name": nameController.text,
      "dropLocation": dropController.text,
      "latitude": dropLat,
      "longitude": dropLng,
      "storeName": selectedStore.value!.name,
      "items": items,
      "homeDelivery": homeDelivery.value,
      "totalAmount": total,
    };


    try {
      await ApiService.placeOrder(orderData);
      Get.snackbar("Success", "Order placed successfully");

      // Reset
      cart.clear();
      selectedStore.value = null;
      homeDelivery.value = false;
      nameController.clear();
      dropController.clear();

      // Refresh orders
      fetchOrders();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  // ---------------- Fetch Orders ----------------
  Future<void> fetchOrders() async {
    try {
      isLoading.value = true;
      final fetchedOrders = await ApiService.fetchOrders();
      orders.value = fetchedOrders;
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch orders");
    } finally {
      isLoading.value = false;
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
