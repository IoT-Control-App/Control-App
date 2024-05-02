import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Lampada extends StatelessWidget {
  const Lampada({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: const Color(0xffff14722)),
        home: const LampadaPage());
  }
}

class LampadaPage extends StatefulWidget {
  const LampadaPage({super.key});

  @override
  State<LampadaPage> createState() => _LampadaPageState();
}

class _LampadaPageState extends State<LampadaPage> {
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
              'Lâmpada',
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
                      onTap: () {
                        print('Ligar/Desligar');
                      },
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
                          onTap: () {
                            print('Aumentar Brilho');
                          },
                        ),
                        const Text('BRILHO', style: TextStyle(fontSize: 20)),
                        GestureDetector(
                          child: const Icon(
                            Icons.keyboard_arrow_down,
                            size: 60,
                          ),
                          onTap: () {
                            print('Diminuir Brilho');
                          },
                        ),
                      ])),
                ),
              
   ] )),
    );
  }
}
