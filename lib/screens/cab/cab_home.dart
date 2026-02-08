import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_care/controllers/cab_controller.dart';
import 'package:parent_care/screens/cab/cab_approval.dart';
import 'package:parent_care/services/api_service.dart';
import 'package:parent_care/utility/invoice_generator.dart';

class CabHome extends StatelessWidget {
  const CabHome({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Cab Request",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.toNamed('/login');
              },
              icon: Icon(Icons.logout),
            ),
          ],
          bottom: TabBar(
            labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500),
            tabs: const [
              Tab(text: "Pending Requests"),
              Tab(text: "Requests"),
            ],
          ),
        ),
        body: TabBarView(children: [CabRequest(), CabList()]),
      ),
    );
  }
}

class CabList extends StatefulWidget {
  const CabList({super.key});

  @override
  State<CabList> createState() => _CabListState();
}

class _CabListState extends State<CabList> {
  final controller = Get.find<CabBookingController>();

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color actionBgColor = isDark ? Colors.white : Colors.black;
    final Color iconColor = isDark ? Colors.black : Colors.white;
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      // Filter only approved cabs
      final approvedCabs = controller.pendingCabs
          .where((cab) => cab.status == "approved")
          .toList();

      if (approvedCabs.isEmpty) {
        return const Center(child: Text("No approved bookings"));
      }

      return ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: approvedCabs.length,
        itemBuilder: (context, index) {
          final cab = approvedCabs[index];

          return Card(
            elevation: 5,
            margin: const EdgeInsets.only(bottom: 15),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  // Left Column
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name: ${cab.name}",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Pickup: ${cab.pickup}",
                        style: GoogleFonts.poppins(),
                      ),
                      Text("Drop: ${cab.drop}", style: GoogleFonts.poppins()),
                      Text(
                        "Time: ${cab.time.hour.toString().padLeft(2, '0')}:${cab.time.minute.toString().padLeft(2, '0')}",
                        style: GoogleFonts.poppins(),
                      ),
                      Text(
                        "Status: ${cab.status}",
                        style: GoogleFonts.poppins(color: Colors.green),
                      ),
                    ],
                  ),
              
                  // Optional Action button
                  GestureDetector(
                    onTap: () {
                      InvoiceGenerator.generateAndOpenInvoice(cab);
                    },
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: actionBgColor,
                      ),
                      child: Icon(Icons.download, color: iconColor),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
