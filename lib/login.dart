import 'package:controle_remoto/services/auth_service.dart';
import 'package:controle_remoto/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:controle_remoto/services/bluetooth_helper.dart';
import 'package:controle_remoto/services/google_assistant_helper.dart';
import 'package:controle_remoto/services/database_helper.dart';
import 'package:controle_remoto:controllers/auth_controller.dart';



class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.red[300]), home: const LoginPage());
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class AuthScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

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

class DeviceScreen extends StatefulWidget {
  @override
  _DeviceScreenState createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  final BluetoothHelper _bluetoothHelper = BluetoothHelper();
  final GoogleAssistantHelper _assistantHelper = GoogleAssistantHelper();
  List<BluetoothDevice> _devices = [];

  @override
  void initState() {
    super.initState();
    _bluetoothHelper.getAvailableDevices().listen((devices) {
      setState(() {
        _devices = devices;
      });
    });
  }

  void _connectAndSendCommand(BluetoothDevice device) async {
    await _bluetoothHelper.connectToDevice(device);
    await _assistantHelper.sendCommand("Turn on the light");
    await _bluetoothHelper.disconnectFromDevice(device);
  }

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffE7DFDF),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          width: 200,
          height: 200,
          decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
          child: const Center(
              child: Text(
            "Logo",
            style: TextStyle(
                color: Color(0xffffffffff),
                fontSize: 30,
                decoration: TextDecoration.none),
          )),
        ),
        const SizedBox(
          height: 70,
        ),
        ElevatedButton(
            onPressed: ()  {
              // AuthService authService = AuthService();
              // print(authService);
              // await authService.signInWithGoogle();

              print("Login");
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const Home()),
                
              );

              
              },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red, // Cor de fundo do botão
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(50), // Raio da borda do botão
              ),
              padding: const EdgeInsets.symmetric(
                  horizontal: 90, vertical: 30), // Espaçamento interno do botão
            ),
            child: const Text(
              "Login",
              style: TextStyle(
                  color: Color(0xffffffffff),
                  fontSize: 30,
                  decoration: TextDecoration.none),
            ))
      ]),
    );
  }
}
