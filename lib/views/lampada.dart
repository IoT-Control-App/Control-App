import 'package:smart_control_app/services/bluetooth_helper.dart';
import 'package:controle_remoto/services/bluetooth_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blue/flutter_blue.dart';


class Lampada extends StatelessWidget {
  const Lampada({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [      
        const Center(
          child: Text(
            'Lâmpada Inteligente',
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
  body: const LampadaPage(),
);
  }
}

class LampadaPage extends StatefulWidget {
  const LampadaPage({super.key});

  @override
  State<LampadaPage> createState() => _LampadaPageState();
}

class _LampadaPageState extends State<LampadaPage> {
   final BluetoothHelper _bluetoothHelper = BluetoothHelper();
  BluetoothDevice? _selectedDevice; 
  int _brightness = 50;

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

  void _turnOnLamp() async {
    if (_selectedDevice != null) {
      await _bluetoothHelper.turnOnLight(_selectedDevice!);
    }
  }

  void _increaseBrightness() async {
    if (_selectedDevice != null && _brightness < 100) {
      _brightness += 10;
      await _bluetoothHelper.setBrightness(_selectedDevice!, _brightness);
    }
  }

  void _decreaseBrightness() async {
    if (_selectedDevice != null && _brightness > 0) {
      _brightness -= 10;
      await _bluetoothHelper.setBrightness(_selectedDevice!, _brightness);
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
                        color: Color(0xfffffffff), shape: BoxShape.circle),
                    child: Center(
                        child: GestureDetector(
                      child: const Icon(Icons.power_settings_new_sharp,
                          color: Colors.black, size: 60),
                      onTap: _turnOnLamp,
                    )),
                  ),
                ],
              ),
              const SizedBox(height: 50),

              Container(
                  
                  width: 90,
                  height: 250,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(50)),
                  child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                        GestureDetector(
                          child: const Icon(Icons.keyboard_arrow_up, size: 60),
                          onTap: _increaseBrightness,
                        ),
                        const Text('BRILHO', style: TextStyle(fontSize: 20)),
                        GestureDetector(
                          child: const Icon(
                            Icons.keyboard_arrow_down,
                            size: 60,
                          ),
                          onTap: _decreaseBrightness,
                        ),
                      ])),
                ),
              
   ] )),
    );
  }
}
