// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pessoa.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PessoaController on _PessoaController, Store {
  final _$statusAtom = Atom(name: '_PessoaController.status');

  @override
  AppStatus get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(AppStatus value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  final _$listAtom = Atom(name: '_PessoaController.list');

  @override
  ObservableList<Pessoa> get list {
    _$listAtom.reportRead();
    return super.list;
  }

  @override
  set list(ObservableList<Pessoa> value) {
    _$listAtom.reportWrite(value, super.list, () {
      super.list = value;
    });
  }

  final _$getAllAsyncAction = AsyncAction('_PessoaController.getAll');

  @override
  Future<void> getAll() {
    return _$getAllAsyncAction.run(() => super.getAll());
  }

  final _$createAsyncAction = AsyncAction('_PessoaController.create');

  @override
  Future<void> create(Pessoa pessoa) {
    return _$createAsyncAction.run(() => super.create(pessoa));
  }

  final _$editAsyncAction = AsyncAction('_PessoaController.edit');

  @override
  Future<void> edit(Pessoa pessoa) {
    return _$editAsyncAction.run(() => super.edit(pessoa));
  }

  final _$deleteAsyncAction = AsyncAction('_PessoaController.delete');

  @override
  Future<void> delete(int id) {
    return _$deleteAsyncAction.run(() => super.delete(id));
  }

  @override
  String toString() {
    return '''
status: ${status},
list: ${list}
    ''';
  }
}
