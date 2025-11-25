import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_care/controllers/food_controller.dart';

class FoodOrderingScreen extends StatelessWidget {
  FoodOrderingScreen({super.key});

  final controller = Get.put(FoodController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyMedium?.color;
    final cardColor = theme.cardColor;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Order Food",
          style: GoogleFonts.poppins(
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
      ),

      body: Obx(
        () => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.hotels.length,
          itemBuilder: (context, index) {
            final hotel = controller.hotels[index];

            return Card(
              color: cardColor,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              margin: const EdgeInsets.only(bottom: 20),
              child: ExpansionTile(
                tilePadding: const EdgeInsets.symmetric(horizontal: 16),
                collapsedIconColor: textColor,
                title: Text(
                  hotel.hotelName,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                children: hotel.menu.map((item) {
                  return ListTile(
                    title: Text(
                      item.name,
                      style: GoogleFonts.poppins(
                        color: textColor,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      "₹${item.price}",
                      style: GoogleFonts.poppins(
                        color: theme.primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: ElevatedButton(
                      onPressed: () => controller.addToCart(item),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "Add",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ),
      ),

          bottomNavigationBar: Obx(
  () {
    double total = controller.cart.fold(0.0, (sum, item) => sum + item.price);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---------- Total Amount ----------
          Text(
            "Total: ₹${total.toStringAsFixed(2)}",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: theme.primaryColor,
            ),
          ),

          const SizedBox(height: 12),

          // ---------- Confirm Button ----------
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: controller.cart.isEmpty
                  ? null
                  : () => controller.confirmOrder(),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "Confirm Order (${controller.cart.length})",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  },
)

      );
  }
}
