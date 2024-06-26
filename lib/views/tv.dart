import 'package:smart_control_app/services/bluetooth_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:permission_handler/permission_handler.dart';

class Tv extends StatelessWidget {
  const Tv({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Center(
              child: Text(
                'Televisão',
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
      body: const TvPage(),
    );
  }
}

class TvPage extends StatefulWidget {
  const TvPage({super.key});

  @override
  State<TvPage> createState() => _TvPageState();
}

class _TvPageState extends State<TvPage> {
  final BluetoothHelper _bluetoothHelper = BluetoothHelper();
  BluetoothDevice? _selectedDevice;
  int _currentChannel = 1;
  int _currentVolume = 50;

  @override
  void initState() {
    super.initState();
    _checkPermissionsAndStartScan();
  }

  void _checkPermissionsAndStartScan() async {
    if (await Permission.location.isGranted &&
        await Permission.bluetooth.isGranted &&
        await Permission.bluetoothScan.isGranted &&
        await Permission.bluetoothConnect.isGranted) {
      _startBluetoothScan();
    } else {
      print('Permissões necessárias não concedidas');
    }
  }

  void _startBluetoothScan() async {
    try {
      await _bluetoothHelper.startScan();
      _bluetoothHelper.getAvailableDevices().listen((devices) {
        setState(() {
          _selectedDevice = devices.isNotEmpty ? devices.first : null;
        });
      });
    } catch (e) {
      print('Error starting scan: $e');
    }
  }

  void _connectToDevice() async {
    if (_selectedDevice != null) {
      await _bluetoothHelper.connectToDevice(_selectedDevice!);
    } else {
      print('No device selected');
    }
  }

  void _turnOnOffTv() async {
    if (_selectedDevice != null) {
      await _bluetoothHelper.turnOnTV(_selectedDevice!);
    }
  }

  void _increaseChannel() async {
    if (_selectedDevice != null) {
      _currentChannel++;
      await _bluetoothHelper.changeChannel(_selectedDevice!, _currentChannel);
    }
  }

  void _decreaseChannel() async {
    if (_selectedDevice != null && _currentChannel > 1) {
      _currentChannel--;
      await _bluetoothHelper.changeChannel(_selectedDevice!, _currentChannel);
    }
  }

  void _increaseVolume() async {
    if (_selectedDevice != null && _currentVolume < 100) {
      _currentVolume += 10;
      await _bluetoothHelper.increaseVolume(_selectedDevice!);
    }
  }

  void _decreaseVolume() async {
    if (_selectedDevice != null && _currentVolume > 0) {
      _currentVolume -= 10;
      await _bluetoothHelper.decreaseVolume(_selectedDevice!);
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
                      onTap: _turnOnOffTv,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Stack(
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[200],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 70,
                        child: GestureDetector(
                          child: const Icon(Icons.keyboard_arrow_up, size: 60),
                          onTap: () {
                            print('Cima');
                          },
                        ),
                      ),
                      Positioned(
                        top: 75,
                        left: 0,
                        child: GestureDetector(
                          child: const Icon(Icons.keyboard_arrow_left, size: 60),
                          onTap: () {
                            print('Esquerda');
                          },
                        ),
                      ),
                      Positioned(
                        top: 75,
                        right: 0,
                        child: GestureDetector(
                          child: const Icon(Icons.keyboard_arrow_right, size: 60),
                          onTap: () {
                            print('Direita');
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 70,
                        child: GestureDetector(
                          child: const Icon(Icons.keyboard_arrow_down, size: 60),
                          onTap: () {
                            print('Baixo');
                          },
                        ),
                      ),
                      Positioned(
                        top: 60,
                        left: 60,
                        right: 60,
                        bottom: 60,
                        child: GestureDetector(
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffE7DFDF),
                            ),
                            child: const Center(
                              child: Text(
                                "OK",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ),
                          ),
                          onTap: () {
                            print('OK');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                margin: const EdgeInsets.only(left: 30),
                width: 70,
                height: 200,
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
                        onTap: _increaseChannel,
                      ),
                      const Text('CH', style: TextStyle(fontSize: 20)),
                      GestureDetector(
                        child: const Icon(
                          Icons.keyboard_arrow_down,
                          size: 60,
                        ),
                        onTap: _decreaseChannel,
                      ),
                    ])),
              ),
              Container(
                margin: const EdgeInsets.only(right: 30),
                width: 70,
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(50)),
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.space_between,
                        children: [
                      GestureDetector(
                        child: const Icon(Icons.keyboard_arrow_up, size: 60),
                        onTap: _increaseVolume,
                      ),
                      const Text('VOL', style: TextStyle(fontSize: 20)),
                      GestureDetector(
                        child: const Icon(
                          Icons.keyboard_arrow_down,
                          size: 60,
                        ),
                        onTap: _decreaseVolume,
                      ),
                    ])),
              ),
            ]),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.space_between,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 30),
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                      color: Color(0xfffffffff), shape: BoxShape.circle),
                  child: GestureDetector(
                    child: const Icon(Icons.menu,
                        color: Colors.black, size: 50),
                    onTap: () {
                      print('Menu');
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 30),
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                      color: Color(0xfffffffff), shape: BoxShape.circle),
                  child: GestureDetector(
                    child: const Icon(Icons.volume_off,
                        color: Colors.black, size: 50),
                    onTap: () {
                      print('Mute');
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
