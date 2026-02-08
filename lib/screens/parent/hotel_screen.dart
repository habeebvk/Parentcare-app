import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:parent_care/controllers/food_controller.dart';

class FoodOrderingScreen extends StatelessWidget {
  FoodOrderingScreen({super.key});

  final controller = Get.find<FoodController>();

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
        () => ListView(
          padding: EdgeInsets.all(w * 0.04),
          children: [
            // ----------- Name Field -----------
            Text(
              "Your Name",
              style: GoogleFonts.poppins(
                fontSize: w * 0.045,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
            SizedBox(height: h * 0.01),
            TextField(
              controller: controller.nameController,
              decoration: InputDecoration(
                hintText: "Enter your name",
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(w * 0.03),
                ),
              ),
            ),
            SizedBox(height: h * 0.01),
            GooglePlaceAutoCompleteTextField(
              textEditingController: controller.dropController,
              focusNode: controller.dropFocus,
              googleAPIKey: "AIzaSyCnXk2YpbWjr5UgTFFflUgfDsagIqwwObE",
              inputDecoration: InputDecoration(
                hintText: "Drop Location",
                prefixIcon: const Icon(Icons.location_on),
              ),
              countries: const ["in"],
              isLatLngRequired: true,

              getPlaceDetailWithLatLng: (Prediction prediction) {
                controller.dropLat = double.tryParse(prediction.lat ?? "");
                controller.dropLng = double.tryParse(prediction.lng ?? "");
              },

              itemClick: (Prediction prediction) {
                controller.dropController.text = prediction.description ?? "";
                controller
                    .dropController
                    .selection = TextSelection.fromPosition(
                  TextPosition(offset: controller.dropController.text.length),
                );
              },

              itemBuilder: (context, index, Prediction prediction) {
                return ListTile(
                  leading: const Icon(Icons.location_on),
                  title: Text(prediction.description ?? ""),
                );
              },

              seperatedBuilder: const Divider(),
              isCrossBtnShown: true,
            ),
            SizedBox(height: h * 0.03),

            // ----------- Hotel List -----------
            ...controller.hotels.map((hotel) {
              return Card(
                color: cardColor,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(w * 0.035),
                ),
                margin: EdgeInsets.only(bottom: h * 0.025),
                child: ExpansionTile(
                  title: Text(
                    hotel.hotelName,
                    style: GoogleFonts.poppins(
                      fontSize: w * 0.045,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  children: hotel.menu.map((item) {
                    return ListTile(
                      title: Text(item.name),
                      subtitle: Text("₹${item.price}"),
                      trailing: ElevatedButton(
                        onPressed: () =>
                            controller.addToCart(item, hotel.hotelName),
                        child: const Text("Add"),
                      ),
                    );
                  }).toList(),
                ),
              );
            }).toList(),
          ],
        ),
      ),
      // ---------------- Bottom Nav -------------------
      bottomNavigationBar: Obx(() {
        double total = controller.cart.fold(
          0.0,
          (sum, item) => sum + item.price,
        );

        return Container(
          padding: EdgeInsets.all(w * 0.04),
          decoration: BoxDecoration(
            color: theme.cardColor,
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
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
      }),
    );
  }
}
