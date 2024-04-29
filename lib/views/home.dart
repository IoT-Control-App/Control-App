import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Color(0xfffF14722)), home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Remote Control App', style: TextStyle(color: Colors.white),)),
        backgroundColor: Color(0xfffF14722),
      ),
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
                        print("Lâmpada Inteligente");
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
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
                        print("Ar Condicionado");
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:10.0),
                      child: Text(
                        "Ar Condicionado",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 50), // Espaçamento entre os Rows
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
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:10.0),
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
                        print("TV Box");
                        }
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:10.0),
                      child: Text(
                        "TV Box",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ],
            ),
        SizedBox(height: 130),
       ElevatedButton(
            onPressed: () async {
              
              },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xfffF14722), // Cor de fundo do botão
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(50), // Raio da borda do botão
              ),
              
              padding: EdgeInsets.symmetric(
                  horizontal: 80, vertical: 15), // Espaçamento interno do botão
            ),
            
            child: Text(
              "Dispostivos Salvos",
              style: TextStyle(
                  color: Color(0xffffffffff),
                  fontSize: 20,
                  decoration: TextDecoration.none),
            )) // Espaçamento entre os Rows
          ],
        ),

      ),
    );
  }
}
