import 'package:controle_remoto/services/bluetooth_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blue/flutter_blue.dart'; // Adicione esta linha para importar a biblioteca flutter_blue

class ArCondicionado extends StatelessWidget {
  const ArCondicionado({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Center(
              child: Text(
                'Ar Condicionado',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                child: const Icon(Icons.edit, color: Colors.white, size: 30),
                onTap: () {
                  print("Editar");
                },
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xffff14722),
      ),
      body: const ArCondicionadoPage(),
    );
  }
}

class ArCondicionadoPage extends StatefulWidget {
  const ArCondicionadoPage({super.key});

  @override
  State<ArCondicionadoPage> createState() => _ArCondicionadoPageState();
}

class _ArCondicionadoPageState extends State<ArCondicionadoPage> {
  final BluetoothHelper _bluetoothHelper = BluetoothHelper();
  BluetoothDevice? _selectedDevice; 
  int _currentTemperature = 25;

  @override
  void initState() {
    super.initState();
    _startBluetoothScan();
  }

  void _startBluetoothScan() async {
    await _bluetoothHelper.startScan();
    _bluetoothHelper.getAvailableDevices().listen((devices) {
      setState(() {
        _selectedDevice = devices.isNotEmpty ? devices.first : null;
      });
    });
  }

  void _connectToDevice() async {
    if (_selectedDevice != null) {
      await _bluetoothHelper.connectToDevice(_selectedDevice!);
      
    } else {
      
      print('No device selected');
    }
  }

  void _turnOnOffAc() async {
    if (_selectedDevice != null) {
      await _bluetoothHelper.turnOnAC(_selectedDevice!);
    }
  }

  void _increaseTemperature() async {
    if (_selectedDevice != null && _currentTemperature < 30) {
      _currentTemperature++;
      await _bluetoothHelper.setACTemperature(_selectedDevice!, _currentTemperature);
    }
  }

  void _decreaseTemperature() async {
    if (_selectedDevice != null && _currentTemperature > 16) {
      _currentTemperature--;
      await _bluetoothHelper.setACTemperature(_selectedDevice!, _currentTemperature);
    }
  }

  @override
  void dispose() {
    _bluetoothHelper.stopScan();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE7DFDF),
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Color(0xfffffffff),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: GestureDetector(
                      child: const Icon(Icons.power_settings_new_sharp,
                          color: Colors.black, size: 60),
                      onTap: _turnOnOffAc,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 200,
                  height: 70,
                  decoration: BoxDecoration(
                    color: const Color(0xfffffffff),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      '$_currentTemperature°C',
                      style: const TextStyle(fontSize: 30),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Container(
              width: 70,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: const Icon(Icons.keyboard_arrow_up, size: 60),
                      onTap: _increaseTemperature,
                    ),
                    const Text('TEMP', style: TextStyle(fontSize: 20)),
                    GestureDetector(
                      child: const Icon(
                        Icons.keyboard_arrow_down,
                        size: 60,
                      ),
                      onTap: _decreaseTemperature,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: Container(
                    width: 131,
                    height: 90,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: const Text(
                        "MODO",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                  onTap: () {
                    print('MODO');
                  },
                ),
                GestureDetector(
                  child: Container(
                    width: 131,
                    height: 90,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: const Text(
                        "VELOCIDADE",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                  onTap: () {
                    print('VELOCIDADE');
                  },
                ),
                GestureDetector(
                  child: Container(
                    width: 130.5,
                    height: 90,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: const Text(
                        "DIREÇÃO",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                  onTap: () {
                    print('DIREÇÃO');
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: Container(
                    width: 131,
                    height: 90,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: const Text(
                        "OSCILAR",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                  onTap: () {
                    print('OSCILAR');
                  },
                ),
                GestureDetector(
                  child: Container(
                    width: 131,
                    height: 90,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: const Text(
                        "TIMER",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                  onTap: () {
                    print('TIMER');
                  },
                ),
                GestureDetector(
                  child: Container(
                    width: 130.5,
                    height: 90,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: const Text(
                        "SUSPENDER",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                  onTap: () {
                    print('SUSPENDER');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
