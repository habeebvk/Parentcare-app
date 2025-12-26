import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_care/controllers/food_controller.dart';

class FoodOrdersScreen extends StatelessWidget {
  final controller = Get.put(FoodOrdersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Orders",style: GoogleFonts.poppins(fontWeight: FontWeight.bold),),
        actions: [
          IconButton(onPressed: (){
            Get.toNamed('/login');
          }, icon: Icon(Icons.logout))
        ],
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.orders.isEmpty) {
          return const Center(child: Text("No orders found"));
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: controller.orders.length,
          itemBuilder: (context, index) {
            final order = controller.orders[index];

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,

              child: ExpansionTile(
                tilePadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),

                // ---------- HEADER ----------
                title: Text(
                  order.storeName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Customer Name
                      Text(
                        order.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      // Total Price
                      Text(
                        "₹${order.total}",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),

                // ---------- BODY ----------
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Drop location
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.location_on, size: 16),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                order.dropLocation,
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),
                        const Divider(),

                        // Items
                        ...order.items.map(
                          (item) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item.name,
                                  style: const TextStyle(fontSize: 14),
                                ),
                                Text(
                                  "₹${item.price}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
