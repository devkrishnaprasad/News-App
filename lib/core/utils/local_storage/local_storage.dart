import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  Future write(String name, dynamic value) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.setString(name, value);
  }

  Future<dynamic> read(String name) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    var storedData = storage.getString(name);
    return storedData;
  }

  clearAllData() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.clear();
  }
}
