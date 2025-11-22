import 'package:parent_care/controllers/item_controller.dart';

class StoreModel {
  final String id;
  final String name;
  final String image;
  final List<GroceryItem> items;

  StoreModel({
    required this.id,
    required this.name,
    required this.image,
    required this.items,
  });
}
