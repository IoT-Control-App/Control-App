import 'package:flutter_blue/flutter_blue.dart';

class BluetoothHelper {
  final FlutterBlue _flutterBlue = FlutterBlue.instance;

  Future<void> startScan() async {
    _flutterBlue.startScan(timeout: Duration(seconds: 4));
  }

  Future<void> stopScan() async {
    _flutterBlue.stopScan();
  }

  Stream<List<BluetoothDevice>> getAvailableDevices() {
    return _flutterBlue.scanResults.map((scanResult) {
      return scanResult.map((result) => result.device).toList();
    });
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    await device.connect();
  }

  Future<void> disconnectFromDevice(BluetoothDevice device) async {
    await device.disconnect();
  }

  // Smart Light
  Future<void> turnOnLight(BluetoothDevice device) async {
    var characteristic = await _getCharacteristic(device, 'turnOnLightUUID');
    await characteristic.write([0x01]); // Supondo que 0x01 liga a lâmpada
  }

  Future<void> turnOffLight(BluetoothDevice device) async {
    var characteristic = await _getCharacteristic(device, 'turnOffLightUUID');
    await characteristic.write([0x00]); // Supondo que 0x00 desliga a lâmpada
  }

  Future<void> setBrightness(BluetoothDevice device, int brightness) async {
    var characteristic = await _getCharacteristic(device, 'setBrightnessUUID');
    await characteristic.write([brightness]); // Ajusta o brilho da lâmpada
  }

  // Smart TV
  Future<void> turnOnTV(BluetoothDevice device) async {
    var characteristic = await _getCharacteristic(device, 'turnOnTVUUID');
    await characteristic.write([0x01]); // Supondo que 0x01 liga a TV
  }

  Future<void> turnOffTV(BluetoothDevice device) async {
    var characteristic = await _getCharacteristic(device, 'turnOffTVUUID');
    await characteristic.write([0x00]); // Supondo que 0x00 desliga a TV
  }

  Future<void> changeChannel(BluetoothDevice device, int channel) async {
    var characteristic = await _getCharacteristic(device, 'changeChannelUUID');
    await characteristic.write([channel]); // Ajusta o canal da TV
  }

  // Air Conditioner
  Future<void> turnOnAC(BluetoothDevice device) async {
    var characteristic = await _getCharacteristic(device, 'turnOnACUUID');
    await characteristic.write([0x01]); // Supondo que 0x01 liga o ar condicionado
  }

  Future<void> turnOffAC(BluetoothDevice device) async {
    var characteristic = await _getCharacteristic(device, 'turnOffACUUID');
    await characteristic.write([0x00]); // Supondo que 0x00 desliga o ar condicionado
  }

  Future<void> setACTemperature(BluetoothDevice device, int temperature) async {
    var characteristic = await _getCharacteristic(device, 'setACTemperatureUUID');
    await characteristic.write([temperature]); // Ajusta a temperatura do ar condicionado
  }

  // TV Box
  Future<void> turnOnTVBox(BluetoothDevice device) async {
    var characteristic = await _getCharacteristic(device, 'turnOnTVBoxUUID');
    await characteristic.write([0x01]); // Supondo que 0x01 liga a TV Box
  }

  Future<void> turnOffTVBox(BluetoothDevice device) async {
    var characteristic = await _getCharacteristic(device, 'turnOffTVBoxUUID');
    await characteristic.write([0x00]); // Supondo que 0x00 desliga a TV Box
  }

  Future<void> navigateTVBox(BluetoothDevice device, String direction) async {
    var characteristic = await _getCharacteristic(device, 'navigateTVBoxUUID');
    await characteristic.write(direction.codeUnits); // Navega na TV Box
  }

  Future<BluetoothCharacteristic> _getCharacteristic(
      BluetoothDevice device, String uuid) async {
    List<BluetoothService> services = await device.discoverServices();
    for (BluetoothService service in services) {
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        if (characteristic.uuid.toString() == uuid) {
          return characteristic;
        }
      }
    }
    throw Exception('Characteristic not found');
  }

  Future<String> detectDeviceType(BluetoothDevice device) async {
    // Placeholder logic to detect device type
    // Use actual methods to get device info
    String deviceName = device.name.toLowerCase();
    if (deviceName.contains('light')) {
      return 'light';
    } else if (deviceName.contains('tv')) {
      return 'tv';
    } else if (deviceName.contains('ac') || deviceName.contains('air conditioner')) {
      return 'ac';
    } else if (deviceName.contains('box')) {
      return 'tvbox';
    } else {
      return 'unknown';
    }
  }
}
