import 'package:get/get.dart';
import 'package:parent_care/controllers/item_controller.dart';
import 'package:parent_care/model/store_model.dart';

class GroceryController extends GetxController {
  Rx<StoreModel?> selectedStore = Rx<StoreModel?>(null);
  RxMap<String, int> cart = <String, int>{}.obs;
  RxBool homeDelivery = false.obs;

  // Dummy store list
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

  void addToCart(GroceryItem item) {
    if (cart.containsKey(item.id)) {
      cart[item.id] = cart[item.id]! + 1;
    } else {
      cart[item.id] = 1;
    }
  }

  void selectStore(StoreModel store) {
    selectedStore.value = store;
    cart.clear();
  }

  double get total {
    double sum = 0;
    cart.forEach((key, qty) {
      final item = selectedStore.value!.items.firstWhere((x) => x.id == key);
      sum += item.price * qty;
    });
    if (homeDelivery.value) sum += 20; // Delivery Fee
    return sum;
  }

  void confirmOrder() {
    if (selectedStore.value == null || cart.isEmpty) {
      Get.snackbar("Error", "Please select items first");
      return;
    }

    Get.snackbar("Order Placed", "Your grocery order is confirmed!");
  }
}
