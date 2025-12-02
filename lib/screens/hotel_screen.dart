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

    // ------- Responsiveness -------
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Order Food",
          style: GoogleFonts.poppins(
            color: textColor,
            fontSize: w * 0.05, // responsive title
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
      ),

      body: Obx(
        () => ListView.builder(
          padding: EdgeInsets.all(w * 0.04),
          itemCount: controller.hotels.length,
          itemBuilder: (context, index) {
            final hotel = controller.hotels[index];

            return Card(
              color: cardColor,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(w * 0.035),
              ),
              margin: EdgeInsets.only(bottom: h * 0.025),
              child: ExpansionTile(
                tilePadding: EdgeInsets.symmetric(horizontal: w * 0.04),
                collapsedIconColor: textColor,
                iconColor: textColor,
                childrenPadding: EdgeInsets.symmetric(
                  horizontal: w * 0.04,
                ),
                title: Text(
                  hotel.hotelName,
                  style: GoogleFonts.poppins(
                    fontSize: w * 0.045,
                    color: textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                children: hotel.menu.map((item) {
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: h * 0.01,
                      horizontal: w * 0.02,
                    ),
                    title: Text(
                      item.name,
                      style: GoogleFonts.poppins(
                        color: textColor,
                        fontSize: w * 0.04,
                      ),
                    ),
                    subtitle: Text(
                      "₹${item.price}",
                      style: GoogleFonts.poppins(
                        color: theme.primaryColor,
                        fontSize: w * 0.038,
                        fontWeight: FontWeight.w600,
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(w * 0.03),
                        ),
                      ),
                      child: Text(
                        "Add",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: w * 0.035,
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

      // ---------------- Bottom Nav -------------------
      bottomNavigationBar: Obx(
        () {
          double total =
              controller.cart.fold(0.0, (sum, item) => sum + item.price);

          return Container(
            padding: EdgeInsets.all(w * 0.04),
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
                    fontSize: w * 0.045,
                    fontWeight: FontWeight.w700,
                    color: theme.primaryColor,
                  ),
                ),

                SizedBox(height: h * 0.015),

                // ---------- Confirm Button ----------
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.cart.isEmpty
                        ? null
                        : () => controller.confirmOrder(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      padding: EdgeInsets.symmetric(vertical: h * 0.02),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(w * 0.03),
                      ),
                    ),
                    child: Text(
                      "Confirm Order (${controller.cart.length})",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: w * 0.04,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
