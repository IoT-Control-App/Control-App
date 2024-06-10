import 'package:controle_remoto/login.dart';
import 'package:controle_remoto/views/arcondicionado.dart';
import 'package:controle_remoto/views/home.dart';
import 'package:controle_remoto/views/lampada.dart';
import 'package:controle_remoto/views/saveddevices.dart';
import 'package:controle_remoto/views/tv.dart';
import 'package:controle_remoto/views/tvbox.dart';
import 'package:flutter/material.dart';
// import 'database_helper.dart';
import 'package:flutter/material.dart';
import 'package:smart_control_app/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);

  runApp(Login());
}
