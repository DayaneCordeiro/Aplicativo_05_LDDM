
import 'package:app_web_papi/models/pessoa.model.dart';
import 'package:app_web_papi/repositories/pessoa.repository.dart';
import 'package:mobx/mobx.dart';
import '../app_status.dart';

part 'pessoa.controller.g.dart';

class PessoaController = _PessoaController with _$PessoaController;

abstract class _PessoaController with Store{

  PessoaRepository repository;

  _PessoaController(){
    repository = new PessoaRepository();
    _init();
  }

  _init() async {
    getAll();
  }

  @observable
  AppStatus status = AppStatus.none;

  @observable
  ObservableList<Pessoa> list = ObservableList<Pessoa>();

  @action
  Future<void> getAll() async {
    status = AppStatus.loading;
    try {
      final allList = await repository.getAll();
      list.clear();
      list.addAll(allList);
      status = AppStatus.success;
    }catch(e){
      status = AppStatus.error..value = e;
    }
  }

  @action
  Future<void> create(Pessoa pessoa) async {
    status = AppStatus.loading;
    try {
      bool isCreated = await repository.create(pessoa);
      if(isCreated) {
        getAll();
        status = AppStatus.success;
      }
      else
        status = AppStatus.error..value = "Erro ao tentar adicionar pessoa!";
    }catch(e){
      status = AppStatus.error..value = e;
    }
  }

  @action
  Future<void> edit(Pessoa pessoa) async {
    status = AppStatus.loading;
    try {
      bool isEdited = await repository.edit(pessoa);
      if(isEdited) {
        getAll();
        status = AppStatus.success;
      }
      else
        status = AppStatus.error..value = "Erro ao tentar alterar pessoa!";
    }catch(e){
      status = AppStatus.error..value = e;
    }
  }

  @action
  Future<void> delete(int id) async {
    status = AppStatus.loading;
    try {
      bool isDeleted = await repository.delete(id);
      if(isDeleted) {
        getAll();
        status = AppStatus.success;
      }
      else
        status = AppStatus.error..value = "Erro ao tentar remover a pessoa!";
    }catch(e){
      status = AppStatus.error..value = e;
    }
  }

}