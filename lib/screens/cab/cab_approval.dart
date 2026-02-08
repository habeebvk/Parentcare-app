import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_care/controllers/cab_controller.dart';

class CabRequest extends StatelessWidget {
  final controller = Get.find<CabBookingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pending Cab Requests")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.pendingCabs.isEmpty) {
          return const Center(child: Text("No pending bookings"));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: controller.pendingCabs.length,
          itemBuilder: (context, index) {
            final cab = controller.pendingCabs[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 15),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name: ${cab.name}",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text("Pickup: ${cab.pickup}", style: GoogleFonts.poppins()),
                    Text("Drop: ${cab.drop}", style: GoogleFonts.poppins()),
                    Text(
                      "Time: ${cab.time.hour.toString().padLeft(2, '0')}:${cab.time.minute.toString().padLeft(2, '0')}",
                      style: GoogleFonts.poppins(),
                    ),
                    Text(
                      "Status: ${cab.status}",
                      style: GoogleFonts.poppins(
                        color: cab.status == "pending"
                            ? Colors.orange
                            : cab.status == "approved"
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (cab.status == "pending")
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () => controller.approve(cab.id),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            child: Text("Accept", style: GoogleFonts.poppins()),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () => controller.reject(cab.id),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: Text(
                              "Decline",
                              style: GoogleFonts.poppins(),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
