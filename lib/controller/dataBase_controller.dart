import 'package:smart_control_app/services/database_helper.dart';

class DatabaseController {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<int> insertDevice(Map<String, dynamic> device) async {
    return await _dbHelper.insertDevice(device);
  }

  Future<List<Map<String, dynamic>>> getDevices() async {
    return await _dbHelper.getDevices();
  }
}