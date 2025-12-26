class CabBookingModel {
  final String id;
  final String name;
  final String pickup;
  final String drop;
  final double? pickupLat;
  final double? pickupLng;
  final double? dropLat;
  final double? dropLng;
  final DateTime time;
  final String status;

  CabBookingModel({
    required this.id,
    required this.name,
    required this.pickup,
    required this.drop,
    this.pickupLat,
    this.pickupLng,
    this.dropLat,
    this.dropLng,
    required this.time,
    required this.status,
  });

  factory CabBookingModel.fromJson(Map<String, dynamic> json) {
    return CabBookingModel(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      pickup: json["pickup"] ?? "",
      drop: json["drop"] ?? "",
      pickupLat: json["pickupLat"] != null
          ? (json["pickupLat"] as num).toDouble()
          : null,
      pickupLng: json["pickupLng"] != null
          ? (json["pickupLng"] as num).toDouble()
          : null,
      dropLat: json["dropLat"] != null
          ? (json["dropLat"] as num).toDouble()
          : null,
      dropLng: json["dropLng"] != null
          ? (json["dropLng"] as num).toDouble()
          : null,
      time: DateTime.parse(json["time"]),
      status: json["status"] ?? "pending",
    );
  }

Map<String, dynamic> toJson() {
  return {
    "name": name,
    "pickup": pickup,
    "drop": drop,
    "pickupLat": pickupLat,
    "pickupLng": pickupLng,
    "time": time.toIso8601String(),
  };
}

}

