import 'package:flutter/material.dart';

AppBarTheme defineAppBar(dynamic cor){
  return AppBarTheme(
      centerTitle: true,
      backgroundColor: cor.primary,
      foregroundColor: cor.onPrimary,
      elevation: 4,
    );
}

BottomNavigationBarThemeData defineNavegacaoBase(dynamic cor){
  return BottomNavigationBarThemeData(
      backgroundColor: cor.primary,
      elevation: 4
    );
}

ElevatedButtonThemeData defineBotaoElevated(dynamic cor) {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom()
  );
}