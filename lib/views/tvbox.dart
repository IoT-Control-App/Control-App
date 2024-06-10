import 'package:smart_control_app/services/bluetooth_helper.dart';
import 'package:controle_remoto/services/bluetooth_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blue/flutter_blue.dart'; // Adicione esta linha para importar a biblioteca flutter_blue

class TvBox extends StatelessWidget {
  const TvBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Center(
              child: Text(
                'Tv Box',
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
      body: const TvBoxPage(),
    );
  }
}

class TvBoxPage extends StatefulWidget {
  const TvBoxPage({super.key});

  @override
  State<TvBoxPage> createState() => _TvBoxPageState();
}

class _TvBoxPageState extends State<TvBoxPage> {
  final BluetoothHelper _bluetoothHelper = BluetoothHelper();
  BluetoothDevice? _selectedDevice; 

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

  void _turnOnOffTvBox() async {
    if (_selectedDevice != null) {
      await _bluetoothHelper.turnOnTVBox(_selectedDevice!);
    }
  }

  void _navigateUp() async {
    if (_selectedDevice != null) {
      await _bluetoothHelper.navigateTVBox(_selectedDevice!, 'up');
    }
  }

  void _navigateDown() async {
    if (_selectedDevice != null) {
      await _bluetoothHelper.navigateTVBox(_selectedDevice!, 'down');
    }
  }

  void _navigateLeft() async {
    if (_selectedDevice != null) {
      await _bluetoothHelper.navigateTVBox(_selectedDevice!, 'left');
    }
  }

  void _navigateRight() async {
    if (_selectedDevice != null) {
      await _bluetoothHelper.navigateTVBox(_selectedDevice!, 'right');
    }
  }

  void _ok() async {
    // if (_selectedDevice != null) {
    //   await _bluetoothHelper.selectTvBox(_selectedDevice!);
    // }
  }

  void _volumeUp() async {
    //faltando esses metodos de volumen tambem 
    // if (_selectedDevice != null) {
    //   await _bluetoothHelper.volumeUp(_selectedDevice!);
    // }
  }

  void _volumeDown() async {
    //faltando esses metodos de volumen tambem 
    // if (_selectedDevice != null) {
    //   await _bluetoothHelper.volumeDown(_selectedDevice!);
    // }
  }

  void _back() async {
    //faltando esses metodos de voltar tambem
    // if (_selectedDevice != null) {
    //   await _bluetoothHelper.backTvBox(_selectedDevice!);
    // }
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
                      onTap: _turnOnOffTvBox,
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
                          onTap: _navigateUp,
                        ),
                      ),
                      Positioned(
                        top: 75,
                        left: 0,
                        child: GestureDetector(
                          child: const Icon(Icons.keyboard_arrow_left, size: 60),
                          onTap: _navigateLeft,
                        ),
                      ),
                      Positioned(
                        top: 75,
                        right: 0,
                        child: GestureDetector(
                          child: const Icon(Icons.keyboard_arrow_right, size: 60),
                          onTap: _navigateRight,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 70,
                        child: GestureDetector(
                          child: const Icon(Icons.keyboard_arrow_down, size: 60),
                          onTap: _navigateDown,
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
                          onTap: _ok,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 300,
                  height: 70,
                  decoration: BoxDecoration(
                    color: const Color(0xfffffffff),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    // Adiciona um Row para conter os botões
                    mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly, // Distribui os botões uniformemente
                    children: [
                      GestureDetector(
                        child: const Icon(Icons.volume_down,
                            color: Colors.black, size: 50),
                        onTap: _volumeDown,
                      ),
                      GestureDetector(
                        // Segundo botão
                        child: const Icon(Icons.volume_up,
                            color: Colors.black, size: 50),
                        onTap: _volumeUp,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 300,
                  height: 70,
                  decoration: BoxDecoration(
                    color: const Color(0xfffffffff),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: GestureDetector(
                    child: const Icon(Icons.subdirectory_arrow_left,
                        color: Colors.black, size: 50),
                    onTap: _back,
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
