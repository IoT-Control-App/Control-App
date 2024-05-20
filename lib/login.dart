import 'package:flutter/material.dart';
import 'package:smart_control_app/services/auth_service.dart';
import 'package:smart_control_app/views/home.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.red[300]), home: LoginPage());
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffE7DFDF),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
          child: Center(
              child: Text(
            "Logo",
            style: TextStyle(
                color: Color(0xffffffffff),
                fontSize: 30,
                decoration: TextDecoration.none),
          )),
        ),
        SizedBox(
          height: 70,
        ),
        ElevatedButton(
            onPressed: () async  {
            await AuthService().signInWithGoogle();
            Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red, // Cor de fundo do botão
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(50), // Raio da borda do botão
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: 90, vertical: 30), // Espaçamento interno do botão
            ),
            child: Text(
              "Login",
              style: TextStyle(
                  color: Color(0xffffffffff),
                  fontSize: 30,
                  decoration: TextDecoration.none),
            ))
      ]),
    );
  }
}