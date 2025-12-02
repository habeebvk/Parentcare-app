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

    // Responsiveness
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: AppBar(
        title: Text(
          "Grocery Booking",
          style: GoogleFonts.poppins(
            fontSize: w * 0.05,      // responsive title
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        centerTitle: true,
      ),

      body: Obx(() {
        return controller.selectedStore.value == null
            ? _buildStoreSelection(theme, textColor, cardColor, w, h)
            : _buildItemSelection(theme, textColor, cardColor, w, h);
      }),

      bottomNavigationBar: Obx(() {
        if (controller.selectedStore.value == null) return const SizedBox();

        return Container(
          padding: EdgeInsets.all(w * 0.04),
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
                  fontSize: w * 0.045,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              ElevatedButton(
                onPressed: controller.confirmOrder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: w * 0.06,
                    vertical: h * 0.015,
                  ),
                ),
                child: Text(
                  "Confirm Order",
                  style: GoogleFonts.poppins(
                    fontSize: w * 0.04,
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
  Widget _buildStoreSelection(
      ThemeData theme, Color? textColor, Color cardColor, double w, double h) {
    return Padding(
      padding: EdgeInsets.all(w * 0.04),
      child: ListView(
        children: [
          Text(
            "Choose Store",
            style: GoogleFonts.poppins(
              fontSize: w * 0.045,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          SizedBox(height: h * 0.02),

          ...controller.stores.map(
            (store) => GestureDetector(
              onTap: () => controller.selectStore(store),
              child: Card(
                margin: EdgeInsets.only(bottom: h * 0.02),
                color: cardColor,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: w * 0.06,
                    backgroundImage: AssetImage(store.image),
                  ),
                  title: Text(
                    store.name,
                    style: GoogleFonts.poppins(
                      fontSize: w * 0.04,
                      color: textColor,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: w * 0.04,
                    color: theme.iconTheme.color,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- Grocery Items -------------------
  Widget _buildItemSelection(
      ThemeData theme, Color? textColor, Color cardColor, double w, double h) {
    return Padding(
      padding: EdgeInsets.all(w * 0.04),
      child: ListView(
        children: [
          Row(
            children: [
              Text(
                "Select Items",
                style: GoogleFonts.poppins(
                  fontSize: w * 0.045,
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
                    fontSize: w * 0.04,
                    color: textColor,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: h * 0.02),

          ...controller.selectedStore.value!.items.map(
            (item) => Card(
              color: cardColor,
              margin: EdgeInsets.only(bottom: h * 0.015),
              child: ListTile(
                title: Text(
                  item.name,
                  style: GoogleFonts.poppins(
                    fontSize: w * 0.04,
                    color: textColor,
                  ),
                ),
                subtitle: Text(
                  "₹${item.price}",
                  style: GoogleFonts.poppins(
                    fontSize: w * 0.038,
                    color: textColor,
                  ),
                ),
                trailing: ElevatedButton(
                  onPressed: () => controller.addToCart(item),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: w * 0.04,
                      vertical: h * 0.01,
                    ),
                  ),
                  child: Text(
                    "Add",
                    style: GoogleFonts.poppins(
                      fontSize: w * 0.035,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: h * 0.025),

          Obx(
            () => SwitchListTile(
              title: Text(
                "Home Delivery (₹20)",
                style: GoogleFonts.poppins(
                  fontSize: w * 0.04,
                  color: textColor,
                ),
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
