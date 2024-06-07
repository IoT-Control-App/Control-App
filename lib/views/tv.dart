import 'package:controle_remoto/services/bluetooth_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blue/flutter_blue.dart'; // Adicione esta linha para importar a biblioteca flutter_blue

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
  BluetoothDevice? _selectedDevice; // Torne _selectedDevice nullable
  int _currentChannel = 1;
  int _currentVolume = 50;

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
      // Add additional logic after connection if needed
    } else {
      // Handle case where no device is selected
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
      //A gente nao fez a funçao de volume, mas deixei pronto aqui de quebradas
      // await _bluetoothHelper.setVolume(_selectedDevice!, _currentVolume);
    }
  }

  void _decreaseVolume() async {
    if (_selectedDevice != null && _currentVolume > 0) {
      _currentVolume -= 10;
      //A gente nao fez a função de volume, mas deixei pronto aqui de quebradas
      // await _bluetoothHelper.setVolume(_selectedDevice!, _currentVolume);
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
                      // Círculo grande
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[200],
                        ),
                      ),
                      // Setinhas dentro do círculo
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
                      // Círculo com o ícone "ok"
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
                              color: Color(0xffE7DFDF), // Cor do círculo
                            ),
                            child: const Center(
                              child: Text(
                                "OK",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ), // Ícone "ok"
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
