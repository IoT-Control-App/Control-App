import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Tv extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Color(0xfffF14722)), home: TvPage());
  }
}

class TvPage extends StatefulWidget {
  const TvPage({super.key});

  @override
  State<TvPage> createState() => _TvPageState();
}

class _TvPageState extends State<TvPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE7DFDF),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              child: Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onTap: () {
                print('Voltar');
              },
            ),
            Center(
                child: Text(
              'Televisão',
              style: TextStyle(color: Colors.white),
            )),
            GestureDetector(
              child: Icon(Icons.edit, color: Colors.white, size: 30),
              onTap: () {
                print("Editar");
              },
            ),
          ],
        ),
        backgroundColor: Color(0xfffF14722),
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
                    decoration: BoxDecoration(
                        color: Color(0xfffffffff), shape: BoxShape.circle),
                    child: Center(
                        child: GestureDetector(
                      child: Icon(Icons.power_settings_new_sharp,
                          color: Colors.black, size: 60),
                      onTap: () {
                        print('Ligar/Desligar');
                      },
                    )),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
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
                            child: Icon(Icons.keyboard_arrow_up, size: 60),
                            onTap: () {
                              print('Cima');
                            },
                          ),
                        ),
                        Positioned(
                          top: 75,
                          left: 0,
                          child: GestureDetector(
                            child: Icon(Icons.keyboard_arrow_left, size: 60),
                            onTap: () {
                              print('Esquerda');
                            },
                          ),
                        ),
                        Positioned(
                          top: 75,
                          right: 0,
                          child: GestureDetector(
                            child: Icon(Icons.keyboard_arrow_right, size: 60),
                            onTap: () {
                              print('Direita');
                            },
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 70,
                          child: GestureDetector(
                            child: Icon(Icons.keyboard_arrow_down, size: 60),
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
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffE7DFDF), // Cor do círculo
                              ),
                              child: Center(
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
              SizedBox(height: 30),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Container(
                  margin: EdgeInsets.only(left: 30),
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
                          child: Icon(Icons.keyboard_arrow_up, size: 60),
                          onTap: () {
                            print('Aumentar canal');
                          },
                        ),
                        Text('CH', style: TextStyle(fontSize: 20)),
                        GestureDetector(
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            size: 60,
                          ),
                          onTap: () {
                            print('Diminuir canal');
                          },
                        ),
                      ])),
                ),
                Container(
                  margin: EdgeInsets.only(right: 30),
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
                          child: Icon(Icons.keyboard_arrow_up, size: 60),
                          onTap: () {
                            print('Aumentar volume');
                          },
                        ),
                        Text('VOL', style: TextStyle(fontSize: 20)),
                        GestureDetector(
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            size: 60,
                          ),
                          onTap: () {
                            print('Diminuir volume');
                          },
                        ),
                      ])),
                ),
              ]),
              SizedBox(height: 30),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 30),
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Color(0xfffffffff), shape: BoxShape.circle),
                    child: GestureDetector(
                      child: Icon(Icons.menu,
                          color: Colors.black, size: 50),
                      onTap: () {
                        print('Menu');
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 30),
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Color(0xfffffffff), shape: BoxShape.circle),
                    child: GestureDetector(
                      child: Icon(Icons.volume_off,
                          color: Colors.black, size: 50),
                      onTap: () {
                        print('Mute');
                      },
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
