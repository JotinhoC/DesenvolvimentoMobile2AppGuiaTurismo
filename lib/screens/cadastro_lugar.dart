import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:guia_turismo/controllers/camera_controller.dart';
import 'package:provider/provider.dart';

class CadastroLugar extends StatefulWidget {
  const new({super.key});

  @override
  State<CadastroLugar> createState() => _CadastroLugarState();
}

class _CadastroLugarState extends State<CadastroLugar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CameraController>(
        builder: (context, controle, _) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    border: Border.all(width: 2),
                    borderRadius: BorderRadius.circular(16),
                    image: exibirImagem(controle)

                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: IconButton(
                    onPressed: () => abrirModal(controle, context),
                    icon: Icon(Icons.camera_alt_rounded)
                  )
                ),
              ],
            ),
          ],
        ),
        ),
    );
  }
}

DecorationImage exibirImagem(CameraController controle) {
  if (controle.imagemSelecionada == null){
    return DecorationImage(image: NetworkImage('https://placehold.co/150x150.png'));
  } else {
    return DecorationImage(
      image: FileImage(controle.imagemSelecionada!)/*FileImage(controle.imagemSelecionada!)*/,
      fit: BoxFit.cover
      );
  }
}

void abrirModal(CameraController controle, context) {
  showModalBottomSheet(
    context: context, 
    builder: (context) =>
      SafeArea(
        bottom: true,
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            ListTile(
              leading: Icon(Icons.camera),
              onTap: () {
                controle.chamarCamera();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_album),
              onTap: (){
                controle.chamarGaleria();
                Navigator.pop(context);
              },
            )
          ],
        )
      ),
  );
}