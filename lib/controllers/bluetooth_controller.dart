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

  // Smart Light
  Future<void> turnOnLight(BluetoothDevice device) async {
    await _bluetoothHelper.turnOnLight(device);
  }

  Future<void> turnOffLight(BluetoothDevice device) async {
    await _bluetoothHelper.turnOffLight(device);
  }

  Future<void> setBrightness(BluetoothDevice device, int brightness) async {
    await _bluetoothHelper.setBrightness(device, brightness);
  }

  // Smart TV
  Future<void> turnOnTV(BluetoothDevice device) async {
    await _bluetoothHelper.turnOnTV(device);
  }

  Future<void> turnOffTV(BluetoothDevice device) async {
    await _bluetoothHelper.turnOffTV(device);
  }

  Future<void> changeChannel(BluetoothDevice device, int channel) async {
    await _bluetoothHelper.changeChannel(device, channel);
  }

  // Air Conditioner
  Future<void> turnOnAC(BluetoothDevice device) async {
    await _bluetoothHelper.turnOnAC(device);
  }

  Future<void> turnOffAC(BluetoothDevice device) async {
    await _bluetoothHelper.turnOffAC(device);
  }

  Future<void> setACTemperature(BluetoothDevice device, int temperature) async {
    await _bluetoothHelper.setACTemperature(device, temperature);
  }

  // TV Box
  Future<void> turnOnTVBox(BluetoothDevice device) async {
    await _bluetoothHelper.turnOnTVBox(device);
  }

  Future<void> turnOffTVBox(BluetoothDevice device) async {
    await _bluetoothHelper.turnOffTVBox(device);
  }

  Future<void> navigateTVBox(BluetoothDevice device, String direction) async {
    await _bluetoothHelper.navigateTVBox(device, direction);
  }

  Stream<List<BluetoothDevice>> getAvailableDevices() {
    return _bluetoothHelper.getAvailableDevices();
  }
}
