import 'package:flutter/material.dart';
import 'package:soar_mobile/resources/socket_manager.dart';
import 'package:soar_mobile/resources/theme_manager.dart';
import 'package:soar_mobile/screens/auth.dart';
import 'package:soar_mobile/screens/home.dart';

void main() {
  SocketManager.connect();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: getApplicationTheme(),
    home: Auth(),
  ));
}
