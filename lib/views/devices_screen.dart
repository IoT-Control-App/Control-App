import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:controle_remoto/controllers/bluetooth_controller.dart';
import 'package:controle_remoto/controllers/database_controller.dart';
import 'package:controle_remoto/controllers/auth_controller.dart';

class DeviceScreen extends StatefulWidget {
  @override
  _DeviceScreenState createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  final BluetoothController _bluetoothController = BluetoothController();
  final DatabaseController _dbController = DatabaseController();
  final AuthController _authController = AuthController();
  List<BluetoothDevice> _devices = [];

  @override
  void initState() {
    super.initState();
    _checkPermissionsAndScan();
    _fetchStoredDevices();
  }

  void _checkPermissionsAndScan() async {
    if (await Permission.location.isGranted && await Permission.bluetooth.isGranted) {
      _bluetoothController.getAvailableDevices().listen((devices) {
        setState(() {
          _devices = devices;
        });
      });
    } else {
      print('Permissões necessárias não concedidas');
    }
  }

  void _fetchStoredDevices() async {
    final devices = await _dbController.getDevices();
    // Process devices if needed
  }

  void _connectAndSendCommand(BluetoothDevice device) async {
    await _bluetoothController.connectToDevice(device);
    String deviceType = await _bluetoothController.detectDeviceType(device);

    switch (deviceType) {
      case 'light':
        await _bluetoothController.turnOnLight(device);
        break;
      case 'tv':
        await _bluetoothController.turnOnTV(device);
        break;
      case 'ac':
        await _bluetoothController.turnOnAC(device);
        break;
      case 'tvbox':
        await _bluetoothController.turnOnTVBox(device);
        break;
      default:
        print('Unknown device type');
    }

    await _bluetoothController.disconnectFromDevice(device);

    // Save device to local database
    await _dbController.insertDevice({
      'name': device.name,
      'ip_address': device.id.toString(),
      'last_connected': DateTime.now().toIso8601String(),
    });
  }

  void _increaseVolume(BluetoothDevice device) async {
    await _bluetoothController.connectToDevice(device);
    await _bluetoothController.increaseVolume(device);
    await _bluetoothController.disconnectFromDevice(device);
  }

  void _decreaseVolume(BluetoothDevice device) async {
    await _bluetoothController.connectToDevice(device);
    await _bluetoothController.decreaseVolume(device);
    await _bluetoothController.disconnectFromDevice(device);
  }

  void _signOut() async {
    await _authController.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => AuthScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Devices'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _signOut,
          ),
        ],
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              _bluetoothController.startScan();
            },
            child: Text('Start Scan'),
          ),
          ElevatedButton(
            onPressed: () {
              _bluetoothController.stopScan();
            },
            child: Text('Stop Scan'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _devices.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_devices[index].name),
                  subtitle: Text(_devices[index].id.toString()),
                  onTap: () {
                    _connectAndSendCommand(_devices[index]);
                  },
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.volume_up),
                        onPressed: () {
                          _increaseVolume(_devices[index]);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.volume_down),
                        onPressed: () {
                          _decreaseVolume(_devices[index]);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
