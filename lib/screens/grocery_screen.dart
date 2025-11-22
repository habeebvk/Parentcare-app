import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_care/controllers/grocery_controller.dart';

class GroceryScreen extends StatelessWidget {
  GroceryScreen({super.key});

  final controller = Get.put(GroceryController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardColor = theme.cardColor;
    final textColor = theme.textTheme.bodyMedium?.color;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: AppBar(
        title: Text(
          "Grocery Booking",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        centerTitle: true,
      ),

      body: Obx(() {
        return controller.selectedStore.value == null
            ? _buildStoreSelection(theme, textColor, cardColor)
            : _buildItemSelection(theme, textColor, cardColor);
      }),

      bottomNavigationBar: Obx(() {
        if (controller.selectedStore.value == null) return const SizedBox();

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cardColor,
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withOpacity(0.1),
                blurRadius: 5,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total: ₹${controller.total.toStringAsFixed(2)}",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              ElevatedButton(
                onPressed: controller.confirmOrder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: Text(
                  "Confirm Order",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  // ------------------ Store List ------------------
  Widget _buildStoreSelection(ThemeData theme, Color? textColor, Color cardColor) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          Text(
            "Choose Store",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 15),

          ...controller.stores.map(
            (store) => GestureDetector(
              onTap: () => controller.selectStore(store),
              child: Card(
                margin: const EdgeInsets.only(bottom: 15),
                color: cardColor,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(store.image),
                  ),
                  title: Text(
                    store.name,
                    style: GoogleFonts.poppins(color: textColor),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios,
                      color: theme.iconTheme.color),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- Grocery Items -------------------
  Widget _buildItemSelection(ThemeData theme, Color? textColor, Color cardColor) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          Row(
            children: [
              Text(
                "Select Items",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => controller.selectedStore.value = null,
                child: Text(
                  "Change Store",
                  style: GoogleFonts.poppins(
                    color: textColor,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 15),

          ...controller.selectedStore.value!.items.map(
            (item) => Card(
              color: cardColor,
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                title: Text(
                  item.name,
                  style: GoogleFonts.poppins(color: textColor),
                ),
                subtitle: Text(
                  "₹${item.price}",
                  style: GoogleFonts.poppins(color: textColor),
                ),
                trailing: ElevatedButton(
                  onPressed: () => controller.addToCart(item),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                  ),
                  child: Text(
                    "Add",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          Obx(
            () => SwitchListTile(
              title: Text(
                "Home Delivery (₹20)",
                style: GoogleFonts.poppins(color: textColor),
              ),
              value: controller.homeDelivery.value,
              onChanged: (v) => controller.homeDelivery.value = v,
              activeColor: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
