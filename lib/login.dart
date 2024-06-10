import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:smart_control_app/services/auth_service.dart';
import 'package:smart_control_app/services/bluetooth_helper.dart';
import 'package:smart_control_app/services/google_assistant_helper.dart';
import 'package:smart_control_app/services/database_helper.dart';
import 'package:smart_control_app/controller/auth_controller.dart';
import 'package:smart_control_app/controller/bluetooth_controller.dart';
import 'package:smart_control_app/controller/database_controller.dart';
import 'package:smart_control_app/views/home.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(Login());
}

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.red[300]),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthController _authController = AuthController();

  void _signIn() async {
    await _authController.signInWithGoogle();
    final status = await Permission.location.request();
    if (status.isGranted) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const Home()),
      );
    } else {
      print('Permission denied');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffE7DFDF),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          width: 200,
          height: 200,
          decoration:
              const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
          child: const Center(
            child: Text(
              "Logo",
              style: TextStyle(
                color: Color(0xffffffff),
                fontSize: 30,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),
        const SizedBox(height: 70),
        ElevatedButton(
          onPressed: _signIn,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 30),
          ),
          child: const Text(
            "Login",
            style: TextStyle(
              color: Color(0xffffffff),
              fontSize: 30,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ]),
    );
  }
}

class AuthScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    // Auth screen content
    return Container();
  }
}

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
    _bluetoothController.getAvailableDevices().listen((devices) {
      setState(() {
        _devices = devices;
      });
    });
    _fetchStoredDevices();
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
                final device = _devices[index];
                return ListTile(
                  title: Text(device.name),
                  subtitle: Text(device.id.toString()),
                  onTap: () {
                    _connectAndSendCommand(device);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
