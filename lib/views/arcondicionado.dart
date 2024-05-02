import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ArCondicionado extends StatelessWidget {
  const ArCondicionado({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: const Color(0xffff14722)),
        home: const ArCondicionadoPage());
  }
}

class ArCondicionadoPage extends StatefulWidget {
  const ArCondicionadoPage({super.key});

  @override
  State<ArCondicionadoPage> createState() => _ArCondicionadoPageState();
}

class _ArCondicionadoPageState extends State<ArCondicionadoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE7DFDF),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              child:
                  const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onTap: () {
                print('Voltar');
              },
            ),
            const Center(
                child: Text(
              'Ar Condicionado',
              style: TextStyle(color: Colors.white),
            )),
            GestureDetector(
              child: const Icon(Icons.edit, color: Colors.white, size: 30),
              onTap: () {
                print("Editar");
              },
            ),
          ],
        ),
        backgroundColor: const Color(0xffff14722),
      ),
      body: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Column(children: [
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
                    onTap: () {
                      print('Ligar/Desligar');
                    },
                  )),
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
                      '25°C',
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
                  borderRadius: BorderRadius.circular(50)),
              child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    GestureDetector(
                      child: const Icon(Icons.keyboard_arrow_up, size: 60),
                      onTap: () {
                        print('Aumentar Temperatura');
                      },
                    ),
                    const Text('TEMP', style: TextStyle(fontSize: 20)),
                    GestureDetector(
                      child: const Icon(
                        Icons.keyboard_arrow_down,
                        size: 60,
                      ),
                      onTap: () {
                        print('Diminuir Temperatura');
                      },
                    ),
                  ])),
            ),
            SizedBox(height: 50),
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
                      child: Text(
                        "MODO",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                  onTap: () {
                    print('OK');
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
                      child: Text(
                        "VELOCIDADE",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                  onTap: () {
                    print('OK');
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
                      child: Text(
                        "DIREÇÃO",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                  onTap: () {
                    print('OK');
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
                      child: Text(
                        "OSCILAR",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                  onTap: () {
                    print('OK');
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
                      child: Text(
                        "TIMER",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                  onTap: () {
                    print('OK');
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
                      child: Text(
                        "SUSPENDER",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                  onTap: () {
                    print('OK');
                  },
                ),
              ],
            )
          ])),
    );
  }
}
