import 'package:controle_remoto/views/arcondicionado.dart';
import 'package:controle_remoto/views/lampada.dart';
import 'package:controle_remoto/views/saveddevices.dart';
import 'package:controle_remoto/views/tvbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:controle_remoto/views/tv.dart';

class Home extends StatelessWidget {
  const Home({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            'Remote Control App',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: const Color(0xffff14722),
      ),
      body: const HomePage(),
      
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: [
                    GestureDetector(
                      child: Image.asset(
                        "assets/lampada.png",
                        width: 130,
                        height: 130,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Lampada()),
                        );
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        "Lâmpada Inteligente",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      child: Image.asset(
                        "assets/arcondicionado.png",
                        width: 130,
                        height: 130,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ArCondicionado()),
                        );
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        "Ar Condicionado",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 50), // Espaçamento entre os Rows
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: [
                    GestureDetector(
                      child: Image.asset(
                        "assets/televisaozinha.png",
                        width: 130,
                        height: 130,
                      ),
                      onTap: () {
                        print("Televisão");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Tv()),
                        );
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        "Televisão",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                        child: Image.asset(
                          "assets/tvbox.png",
                          width: 130,
                          height: 130,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const TvBox()),
                          );
                        }),
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        "TV Box",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 130),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SavedDevices()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffff14722), // Cor de fundo do botão
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50), // Raio da borda do botão
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 80, vertical: 15), // Espaçamento interno do botão
              ),
              child: const Text(
                "Dispositivos Salvos",
                style: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 20,
                    decoration: TextDecoration.none),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DispositivosSalvos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dispositivos Salvos"),
      ),
      body: Center(
        child: Text("Esta é a tela de Dispositivos Salvos"),
      ),
    );
  }
}
