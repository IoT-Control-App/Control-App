import 'package:flutter_blue/flutter_blue.dart';
import '../services/bluetooth_helper.dart';

class BluetoothController {
  final BluetoothHelper _bluetoothHelper = BluetoothHelper();

  void startScan() {
    _bluetoothHelper.startScan();
  }

  void stopScan() {
    _bluetoothHelper.stopScan();
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    await _bluetoothHelper.connectToDevice(device);
  }

  Future<void> disconnectFromDevice(BluetoothDevice device) async {
    await _bluetoothHelper.disconnectFromDevice(device);
  }

  Stream<List<BluetoothDevice>> getAvailableDevices() {
    return _bluetoothHelper.getAvailableDevices();
  }
}