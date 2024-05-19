import 'package:flutter_blue/flutter_blue.dart';

class BluetoothHelper {
  final FlutterBlue _flutterBlue = FlutterBlue.instance;

  // Start scanning for devices
  void startScan() {
    _flutterBlue.startScan(timeout: Duration(seconds: 4));
  }

  // Stop scanning for devices
  void stopScan() {
    _flutterBlue.stopScan();
  }

  // Connect to a device
  Future<void> connectToDevice(BluetoothDevice device) async {
    await device.connect();
  }

  // Disconnect from a device
  Future<void> disconnectFromDevice(BluetoothDevice device) async {
    await device.disconnect();
  }

  // Get the list of available devices
  Stream<List<BluetoothDevice>> getAvailableDevices() {
    return _flutterBlue.scanResults.map((results) {
      return results.map((result) => result.device).toList();
    });
  }
}
