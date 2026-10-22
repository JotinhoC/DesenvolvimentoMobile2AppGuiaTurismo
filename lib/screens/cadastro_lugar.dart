import 'package:flutter/material.dart';
import 'package:guia_turismo/controllers/camera_controller.dart';
import 'package:guia_turismo/models/lugares_model.dart';
import 'package:guia_turismo/services/lugares_service.dart';
import 'package:provider/provider.dart';

class CadastroLugar extends StatefulWidget {
  const new({super.key});

  @override
  State<CadastroLugar> createState() => _CadastroLugarState();
}

class _CadastroLugarState extends State<CadastroLugar> {
  //=====================================================
  final _nomeController = TextEditingController();
  final _descController = TextEditingController();
  final _latiController = TextEditingController();
  final _longiController = TextEditingController();
  final _categoriaIdController = TextEditingController();
  final _token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzkyNjI2NDIyLCJleHAiOjE3OTI3MTI4MjJ9.XMdsk_1pP-e9B9ZRpV9Vd_Tk93oijekFb02owwgJrLM";
  //=====================================================
  @override

  void abrirFormulario(){
    showDialog(context: context, 
      builder: (context) {
        return AlertDialog(
          title: Text("Cadastro"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nomeController,
                decoration: InputDecoration(
                  label: Text("Nome")
                ),
              ),
              SizedBox(height: 20,),

              TextField(
                controller: _descController,
                decoration: InputDecoration(
                  label: Text("Descrição")
                ),
              ),
              SizedBox(height: 20,),

              TextField(
                controller: _latiController,
                decoration: InputDecoration(
                  label: Text("Latitude")
                ),
              ),
              SizedBox(height: 20,),

              TextField(
                controller: _longiController,
                decoration: InputDecoration(
                  label: Text("Longitude")
                ),
              ),
              SizedBox(height: 20,),

              TextField(
                controller: _categoriaIdController,
                decoration: InputDecoration(
                  label: Text("Categoria ID")
                ),
              ),
              SizedBox(height: 20,),
            ],
          ),

          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancelar")),
            TextButton(onPressed: (){
              _salvarDados();
            }, child: Text("Salvar"))
          ],
        );
      });
  }

  void _salvarDados () async {
    final novoLugar = LugaresModel(
      nome: _nomeController.text, 
      descricao: _descController.text,
      latitude: double.parse(_latiController.text), 
      longitude: double.parse(_longiController.text), 
      categoriaId: int.parse(_categoriaIdController.text)
      );

      LugaresService().cadastrarLugar(novoLugar, _token);

      _nomeController.clear();
      _descController.clear();
      _latiController.clear();
      _longiController.clear();
      _categoriaIdController.clear();
      Navigator.of(context).pop;
  }

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

            FloatingActionButton(onPressed: (){
              abrirFormulario();
            }, child: Icon(Icons.add),)
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