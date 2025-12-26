import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:parent_care/model/appointment_model.dart';
import 'package:parent_care/model/cab_booking.dart';
import 'package:parent_care/model/food_order.dart';
import 'package:parent_care/model/grocery_model.dart';

class ApiService {
  static const baseUrl = "http://192.168.1.40:5000/api/";


      Future<bool> register(String name, String email, String password) async {
      final uri = Uri.parse('${baseUrl}parent/register');
      final res = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
        }),
      );

      return res.statusCode == 201;
    }


    Future<bool> login(String email, String password) async {
      final uri = Uri.parse('${baseUrl}parent/login');
      final res = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      print("STATUS: ${res.statusCode}");
      print("BODY: ${res.body}");

      return res.statusCode == 200;
    }


  // ---------------- POST NEW APPOINTMENT ----------------
  static Future<void> addData(Map<String, dynamic> pdata) async {
    final uri = Uri.parse('${baseUrl}add_appointment');

    try {
      final response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(pdata),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("✅ Appointment Added: $data");
      } else {
        print("❌ Failed to add appointment: ${response.statusCode}");
        print(response.body);
      }
    } catch (e) {
      print("❌ Error: $e");
    }
  }

  // ---------------- GET ALL APPOINTMENTS ----------------
static Future<List<Appointment>> getData() async {
  final uri = Uri.parse('${baseUrl}get_appointment');
  final res = await http.get(uri);

  if (res.statusCode == 200) {
    final decoded = jsonDecode(res.body);
    List<Appointment> list = [];

    for (var value in decoded['appointments']) {
      list.add(Appointment(
        id: value['_id']?.toString() ?? "",
        name: value['name']?.toString() ?? "",
        hospital: value['hospital']?.toString() ?? "",
        date: value['date']?.toString() ?? "",
        time: value['time']?.toString() ?? "",
        status: value['status'].toString(),
      ));
    }
    return list;
  } else {
    print("❌ Failed to fetch appointments: ${res.statusCode}");
    return [];
  }
}

// ---------------- APPROVE APPOINTMENT ----------------
static Future<bool> approveAppointment(String id) async {
  final uri = Uri.parse('${baseUrl}appointments/approve/$id');

  try {
    final res = await http.put(uri);

    if (res.statusCode == 200) {
      return true;
    } else {
      print("❌ Approve failed: ${res.body}");
      return false;
    }
  } catch (e) {
    print("❌ Error approving appointment: $e");
    return false;
  }
}


// ---------------- REJECT APPOINTMENT ----------------
static Future<bool> rejectAppointment(String id) async {
  final uri = Uri.parse('${baseUrl}reject_appointment/$id');

  final res = await http.put(uri);

  if (res.statusCode == 200) {
    return true;
  } else {
    print("❌ Reject failed: ${res.body}");
    return false;
  }
}
 
   static Future<List<Appointment>> getApprovedAppointments() async {
    final res = await http.get(
      Uri.parse("${baseUrl}appointments/approved"),
    );

    if (res.statusCode == 200) {
      final decoded = jsonDecode(res.body)["appointments"] as List;

      return decoded.map((e) => Appointment(
        id: e['_id']?.toString() ?? "",
        name: e['name']?.toString() ?? "",
        hospital: e['hospital']?.toString() ?? "",
        date: e['date']?.toString() ?? "",
        time: e['time']?.toString() ?? "",
        status: e['status'].toString(),
      )).toList();
    } else {
      return [];
    }
  }

  
 static Future<bool> cancelAppointment(String appointmentId) async {
    try {
      final uri = Uri.parse(
        "${baseUrl}appointments/cancel/$appointmentId",
      );

      final response = await http.put(
        uri,
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print("❌ Cancel failed: ${response.body}");
        return false;
      }
    } catch (e) {
      print("❌ Cancel error: $e");
      return false;
    }
  }


static Future<bool> bookCab(CabBookingModel booking) async {
  try {
    final body = booking.toJson();

    print("📤 Sending Cab Booking: $body");

    final res = await http.post(
      Uri.parse("${baseUrl}cab/book"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    print("📥 Status: ${res.statusCode}");
    print("📥 Response: ${res.body}");

    return res.statusCode == 200 || res.statusCode == 201;
  } catch (e) {
    print("❌ Cab booking error: $e");
    return false;
  }
}


static Future<List<CabBookingModel>> getPendingCabs() async {
  try {
    final res = await http.get(
      Uri.parse("${baseUrl}cab/pending"),
    );

    print("STATUS: ${res.statusCode}");
    print("BODY: ${res.body}");

    if (res.statusCode == 200) {
      final decoded = jsonDecode(res.body) as List;
      return decoded
          .map((e) => CabBookingModel.fromJson(e))
          .toList();
    }
    return [];
  } catch (e) {
    print("❌ getPendingCabs error: $e");
    return [];
  }
}


// ---------------- APPROVE CAB ----------------
static Future<bool> approveCab(String id) async {
    try {
      final res = await http.put(Uri.parse("${baseUrl}cab/approve/$id"),
      
      );
      return res.statusCode == 200;
    } catch (e) {
      print("❌ approveCab error: $e");
      return false;
    }
  }

  // Reject cab
  static Future<bool> rejectCab(String id) async {
    try {
      final res = await http.put(Uri.parse("${baseUrl}cab/reject/$id"));
      return res.statusCode == 200;
    } catch (e) {
      print("❌ rejectCab error: $e");
      return false;
    }
  }

  static Future<void> placeOrder(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse("${baseUrl}grocery/order"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      print(response.body);
      throw Exception("Order failed: ${response.body}");
    }
  }


    static Future<List<GroceryOrderModel>> fetchOrders() async {
      final response =
          await http.get(Uri.parse("${baseUrl}grocery/get_orders"));

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        return data
            .map((e) => GroceryOrderModel.fromJson(e))
            .toList();
      } else {
        throw Exception("Failed to fetch orders");
      }
    }
 
   static Future<void> placeFoodOrder(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse("${baseUrl}food/order"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    if (response.statusCode != 201) {
      throw Exception(response.body);
    }
  }

static Future<List<FoodOrder>> fetchFoodOrders() async {
  final response = await http.get(
    Uri.parse("${baseUrl}food/orders"),
    headers: {"Content-Type": "application/json"},
  );

  print("STATUS CODE: ${response.statusCode}");

  if (response.statusCode == 200) {
    final List data = jsonDecode(response.body);
    return data.map((e) => FoodOrder.fromJson(e)).toList();
  } else {
    throw Exception(response.body); // 🔥 SHOW REAL ERROR
  }
}


}

