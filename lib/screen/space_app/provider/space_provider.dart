import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pr6_space_app/screen/space_app/modal/space_modal.dart';

class SpaceProvider with ChangeNotifier {
 List<SpaceModal> jsonData = [];

 Future<void> convert(List<dynamic> data) async {
  jsonData = data.map((item) => SpaceModal.fromJson(item)).toList();
  notifyListeners();
 }
}
