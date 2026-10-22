import 'package:flutter/material.dart';
import 'package:guia_turismo/models/lugares_model.dart';
import 'package:guia_turismo/services/lugares_service.dart';

class LugaresController extends ChangeNotifier{
  bool carregando = false;
  String erro = '';
  List<LugaresModel> _lugares = [];
  List<LugaresModel> get lugares => _lugares;

  //Inicializar 
  LugaresController() {
    listarLugares();
  }

  Future<void> listarLugares() async {
    carregando = true;
    notifyListeners();
    try{
      final lugaresService = LugaresService();
      final listaLugares = await lugaresService.buscarLugares();
      _lugares = listaLugares; 
    } catch(error){
      erro = "Erro ao listar: ${error.toString()}";

    } finally {
      carregando = false;
      notifyListeners();
    }
  }

  Future<String> cadastrarLugar(LugaresModel dados) async {
    //final token = await SessionService().pegarToken() ?? '';
    carregando = true;
    erro = "";
    notifyListeners();
    try {
      final lugaresService = LugaresService();
      final resposta = await lugaresService.cadastrarLugar(dados, "");
      return resposta;
    }catch(e){
      erro = "Erro ao cadastrar: $e";
      return erro;
    }finally{
      carregando = false;
      notifyListeners();
    }
  }
}