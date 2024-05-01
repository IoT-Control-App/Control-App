import 'package:controle_remoto/services/auth_service.dart';
import 'package:flutter/material.dart';


class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.red[300]), home: const LoginPage());
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
      color: const Color(0xffE7DFDF),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          width: 200,
          height: 200,
          decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
          child: const Center(
              child: Text(
            "Logo",
            style: TextStyle(
                color: Color(0xffffffffff),
                fontSize: 30,
                decoration: TextDecoration.none),
          )),
        ),
        const SizedBox(
          height: 70,
        ),
        ElevatedButton(
            onPressed: () async {
              AuthService authService = AuthService();
              await authService.signInWithGoogle();
              },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red, // Cor de fundo do botão
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(50), // Raio da borda do botão
              ),
              padding: const EdgeInsets.symmetric(
                  horizontal: 90, vertical: 30), // Espaçamento interno do botão
            ),
            child: const Text(
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
