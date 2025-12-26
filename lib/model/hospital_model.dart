import 'package:get/get_rx/src/rx_types/rx_types.dart';

class Hospital {
  final int id;
  final String name;
  final String address;

  Hospital({required this.id, required this.name, required this.address});
}

class AppointmentRequest {
  String id;
  String userName;
  String date;
  String time;
  String tokenNumber;
  String tokenDate; // <-- add this

  AppointmentRequest({
    required this.id,
    required this.userName,
    required this.date,
    required this.time,
    this.tokenNumber = "",
    this.tokenDate = "", // <-- default empty
  });
}




