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
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ipController = TextEditingController();
  List<Map<String, dynamic>> _devices = [];

  @override
  void initState() {
    super.initState();
    _fetchDevices();
  }
}

 void _fetchDevices() async {
    final devices = await _dbHelper.getDevices();
    setState(() {
      _devices = devices;
    });
  }

  void _addDevice() async {
    final device = {
      'name': _nameController.text,
      'ip_address': _ipController.text,
      'last_connected': DateTime.now().toIso8601String(),
    };
    await _dbHelper.insertDevice(device);
    _nameController.clear();
    _ipController.clear();
    _fetchDevices();
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
