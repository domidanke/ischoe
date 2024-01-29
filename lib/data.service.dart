import 'package:shared_preferences/shared_preferences.dart';

class DataService {
  factory DataService() {
    return _singleton;
  }
  DataService._internal();
  static final DataService _singleton = DataService._internal();

  SharedPreferences? prefs;

  Future loadLocalData() async {
    prefs = await SharedPreferences.getInstance();
  }

  int getIschoeCount() => prefs?.getInt('ischoe_count') ?? 0;

  Future increaseIschoe() async {
    final oldIndex = getIschoeCount();
    await prefs?.setInt('ischoe_count', oldIndex + 1);
  }
}
