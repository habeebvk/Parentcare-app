import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parent_care/controllers/item_controller.dart';
import 'package:parent_care/model/store_model.dart';

class GroceryController extends GetxController {
  // ---------------- STORE LIST (Dummy Data) ----------------
  RxList<StoreModel> stores = <StoreModel>[
    StoreModel(
      id: "1",
      name: "Fresh Mart",
      image: "assets/curd-premium.png",
      items: [
        GroceryItem(id: "i1", name: "Tomatoes", price: 30),
        GroceryItem(id: "i2", name: "Onions", price: 40),
        GroceryItem(id: "i3", name: "Milk", price: 25),
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

  // ---------------- STATE VARIABLES ----------------
  Rx<StoreModel?> selectedStore = Rx<StoreModel?>(null);
  RxMap<String, int> cart = <String, int>{}.obs; // itemId → qty
  RxBool homeDelivery = false.obs;

  // ---------------- SELECT STORE ----------------
  void selectStore(StoreModel store) {
    selectedStore.value = store;
    cart.clear();
  }

  // ---------------- ADD ITEM TO CART ----------------
  void addToCart(GroceryItem item) {
    if (cart.containsKey(item.id)) {
      cart[item.id] = cart[item.id]! + 1;
    } else {
      cart[item.id] = 1;
    }
  }

  // ---------------- TOTAL PRICE ----------------
  double get total {
    double sum = 0;

    cart.forEach((itemId, qty) {
      final item =
          selectedStore.value!.items.firstWhere((element) => element.id == itemId);
      sum += item.price * qty;
    });

    if (homeDelivery.value) sum += 20;

    return sum;
  }

  // ---------------- FIREBASE SAVE ORDER ----------------
  Future<void> confirmOrder() async {
    if (selectedStore.value == null || cart.isEmpty) {
      Get.snackbar("Error", "Please add items to the cart!");
      return;
    }

    try {
      // Convert cart → Firebase-friendly format
      List<Map<String, dynamic>> itemsList = cart.entries.map((entry) {
        final item = selectedStore.value!.items
            .firstWhere((element) => element.id == entry.key);

        return {
          "id": item.id,
          "name": item.name,
          "price": item.price,
          "quantity": entry.value,
          "total": item.price * entry.value
        };
      }).toList();

      await FirebaseFirestore.instance.collection("grocery_orders").add({
        "store_id": selectedStore.value!.id,
        "store_name": selectedStore.value!.name,
        "items": itemsList,
        "home_delivery": homeDelivery.value,
        "total_price": total,
        "createdAt": Timestamp.now(),
      });

      // Show dialog
      Get.defaultDialog(
        title: "Order Confirmed",
        middleText: "Your grocery order has been placed successfully!",
      );

      // Reset after order
      selectedStore.value = null;
      cart.clear();
      homeDelivery.value = false;

    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
