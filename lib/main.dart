import 'package:flutter/material.dart';
import 'package:guia_turismo/controllers/camera_controller.dart';
import 'package:guia_turismo/controllers/lugares_controller.dart';
import 'package:guia_turismo/controllers/theme_controller.dart';
import 'package:guia_turismo/screens/cadastro_lugar.dart';
import 'package:guia_turismo/screens/lugares_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(Inicializar( ));
}

class Inicializar extends StatefulWidget {
  const new({super.key});

  @override
  State<Inicializar> createState() => _InicializarState();
}

class _InicializarState extends State<Inicializar> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LugaresController()),
        ChangeNotifierProvider(create: (_) => ThemeController()),
        ChangeNotifierProvider(create: (_) => CameraController()),
      ],
        //child: Consumer<ThemeController>(
        //builder: (context, lugaresController, child) => 
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: 'lugares',
          routes: {
            'lugares': (context) => LugaresScreen(),
            'cadastro': (context) => CadastroLugar(),
          }
        ),
      );
  }
}