import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SavedDevices extends StatelessWidget {
  const SavedDevices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Remote Control App',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: const Color(0xffff14722),
      ),
      body: const SavedDevicesPage(),
    );
  }
}

class SavedDevicesPage extends StatefulWidget {
  const SavedDevicesPage({super.key});

  @override
  State<SavedDevicesPage> createState() => _SavedDevicesPageState();
}

class _SavedDevicesPageState extends State<SavedDevicesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE7DFDF),
      
      body: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: 390,
                    height: 50,
                    decoration: const BoxDecoration(
                        color: Color(0xfffffffff), shape: BoxShape.rectangle),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/lampada.png",
                            width: 50,
                            height: 50,
                          ),
                          const Text(
                            "Ar Condicionado",
                          ),
                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(child: Icon(Icons.delete, color: Colors.black, size: 30),
                              onTap: () {
                                print('Deletar');
                              
                              },),
                              GestureDetector(child: Icon(Icons.edit, color: Colors.black, size: 30),
                              onTap: () {
                                print('Editar');
                              },),
                            ],
                          ),
                        ])),
                        
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: 390,
                    height: 50,
                    decoration: const BoxDecoration(
                        color: Color(0xfffffffff), shape: BoxShape.rectangle),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/lampada.png",
                            width: 50,
                            height: 50,
                          ),
                          const Text(
                            "Ar Condicionado",
                          ),
                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(child: Icon(Icons.delete, color: Colors.black, size: 30),
                              onTap: () {
                                print('Deletar');
                              
                              },),
                              GestureDetector(child: Icon(Icons.edit, color: Colors.black, size: 30),
                              onTap: () {
                                print('Editar');
                              },),
                            ],
                          ),
                        ])),
                        const SizedBox(
                          height: 30,
                        ),
              ],
            ),
            const SizedBox(height: 50),
          ])),
    );
  }
}
