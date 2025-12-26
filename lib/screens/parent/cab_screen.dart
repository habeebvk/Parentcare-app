import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:parent_care/controllers/cab_controller.dart';
import 'package:parent_care/model/cab_booking.dart';
import 'package:parent_care/screens/parent/cab_bookings.dart';
import 'package:parent_care/services/api_service.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';


class CabMainScreen extends StatelessWidget {
  const CabMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Cab Services",
            style: GoogleFonts.poppins(
              fontSize: width < 500 ? 20 : 26,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: const Color(0xffeb4034),
            labelStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
            ),
            tabs: const [
              Tab(icon: Icon(Icons.local_taxi), text: "Cab Book"),
              Tab(icon: Icon(Icons.list_alt), text: "Bookings"),
            ],
          ),
        ),
        body:  TabBarView(
          children: [
            CabBookingScreen(),
            CabScreen(),
          ],
        ),
      ),
    );
  }
}






class CabBookingScreen extends StatefulWidget {
  CabBookingScreen({super.key});

  @override
  State<CabBookingScreen> createState() => _CabBookingScreenState();
}

class _CabBookingScreenState extends State<CabBookingScreen> {
  final controller = Get.put(CabBookingController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ------------ RESPONSIVE VALUES ------------
    final width = MediaQuery.of(context).size.width;

      double sectionTitleSize = width < 500 ? 18 : 22;
    double inputFontSize = width < 500 ? 15 : 17;
    double padding = width < 500 ? 20 : 30;
    double spacing = width < 500 ? 12 : 20;
    double buttonHeight = width < 500 ? 55 : 65;

    final cardColor = theme.cardColor;
    final textColor = theme.textTheme.bodyMedium?.color;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(padding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // -------- Select Hospital ----------
              Text(
                "Enter Name",
                style: GoogleFonts.poppins(
                  fontSize: sectionTitleSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spacing),
      
              TextField(
                controller: controller.nameController,
                focusNode: controller.nameFocus,
                decoration: InputDecoration(
                  hint: Text("Enter Name",style: GoogleFonts.poppins()),
                  suffixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: spacing * 2),
      
              // -------- Select Date ----------
              Text(
                "Enter Pickup Location",
                style: GoogleFonts.poppins(
                  fontSize: sectionTitleSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spacing),
          GooglePlaceAutoCompleteTextField(
            textEditingController: controller.pickupController,
            focusNode: controller.pickupFocus,
            googleAPIKey: "AIzaSyCnXk2YpbWjr5UgTFFflUgfDsagIqwwObE",
            inputDecoration: InputDecoration(
              hintText: "Pickup Location",
              suffixIcon: const Icon(Icons.location_on),
            ),
            debounceTime: 600,
            countries: const ["in"], // India only (optional)
            isLatLngRequired: true,
            getPlaceDetailWithLatLng: (Prediction prediction) {
              controller.pickupLat =
                  double.tryParse(prediction.lat ?? "");
              controller.pickupLng =
                  double.tryParse(prediction.lng ?? "");
            },

            itemClick: (Prediction prediction) {
              controller.pickupController.text =
                  prediction.description ?? "";
              controller.pickupController.selection =
                  TextSelection.fromPosition(
                TextPosition(
                  offset: controller.pickupController.text.length,
                ),
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


              SizedBox(height: spacing * 2),
      
              // -------- Select Time ----------
              Text(
                "Enter Drop Location",
                style: GoogleFonts.poppins(
                  fontSize: sectionTitleSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spacing),
      
              GooglePlaceAutoCompleteTextField(
                textEditingController: controller.dropController,
                focusNode: controller.dropFocus,
                googleAPIKey: "AIzaSyCnXk2YpbWjr5UgTFFflUgfDsagIqwwObE",
                inputDecoration: InputDecoration(
                  hintText: "Drop Location",
                  suffixIcon: const Icon(Icons.location_on),
                ),
                countries: const ["in"],
                isLatLngRequired: true,

            getPlaceDetailWithLatLng: (Prediction prediction) {
              controller.dropLat =
                  double.tryParse(prediction.lat ?? "");
              controller.dropLng =
                  double.tryParse(prediction.lng ?? "");
            },

            itemClick: (Prediction prediction) {
              controller.dropController.text =
                  prediction.description ?? "";
              controller.dropController.selection =
                  TextSelection.fromPosition(
                TextPosition(
                  offset: controller.dropController.text.length,
                ),
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

              SizedBox(height: spacing * 2),   
              // -------- Select Time ----------
              Text(
                "Select Time",
                style: GoogleFonts.poppins(
                  fontSize: sectionTitleSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spacing,),
      
              TextField(
                controller: controller.timeController,
                focusNode: controller.timeFocus,
                readOnly: true,
                onTap: () => controller.chooseTime(context),
                decoration: InputDecoration(
                  hintText: "Select Time",
                  suffixIcon: const Icon(Icons.timer),
                ),
              ),
              SizedBox(height: spacing * 3),
      
              // -------- Confirm Button ----------
              SizedBox(
                width: double.infinity,
                height: buttonHeight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    controller.submitBooking();
                  },
                  child: Text(
                    "Confirm Booking",
                    style: GoogleFonts.poppins(
                      fontSize: width < 500 ? 18 : 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height:10),
              const ButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}


class ButtonWidget extends StatefulWidget {
  const ButtonWidget({super.key});

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Payment Successful: ${response.paymentId}"),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response.message ?? "Payment Failed"),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Wallet: ${response.walletName}")),
    );
  }

  void _openRazorpay() {
    var options = {
      'key': 'rzp_test_RZBBdT1yj6ZP2M',
      'amount': 50000,
      'currency': 'INR',
      'name': 'ECE Store',
      'description': 'Cab Booking Payment',
      'method': {
        'upi': true,
        'card': true,
        'wallet': true,
        'netbanking': true,
      },
    };

    _razorpay.open(options);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _openRazorpay,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 251, 221, 172),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(15)
          )
        ),
        child: Text(
          "Pay via UPI",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: width < 500 ? 18 : 20,
          ),
        ),
      ),
    );
  }
}



class PaymentBottomSheet extends StatelessWidget {
  const PaymentBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Select Payment Method',
            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // COD
          ElevatedButton(
            onPressed: () => Navigator.pop(context, 'cod'),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(15)
              ),
              backgroundColor:  Color.fromARGB(255, 251, 221, 172),
              padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 72),
            ),
            child: Text('Cash on Drop (COD)',
                style: GoogleFonts.poppins(fontSize: 16, color: Colors.black)),
          ),
          const SizedBox(height: 12),

          // UPI
          ElevatedButton(
            onPressed: () => Navigator.pop(context, 'upi'),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(15)
              ),
              backgroundColor: Color(0xFFB3E5FC),
              padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 124),
            ),
            child: Text('Pay via UPI',
                style: GoogleFonts.poppins(fontSize: 16, color: Colors.black)),
          ),
        ],
      ),
    );
  }
}

