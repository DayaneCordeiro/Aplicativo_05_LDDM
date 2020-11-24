import 'package:app_web_papi/controllers/pessoa.controller.dart';
import 'package:app_web_papi/models/pessoa.model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PessoaFormView extends StatefulWidget {
  final Pessoa pessoa;

  PessoaFormView({this.pessoa});

  @override
  _PessoaFormViewState createState() => _PessoaFormViewState();
}

class _PessoaFormViewState extends State<PessoaFormView> {
  final _tId = TextEditingController();
  final _tNome = TextEditingController();
  final _tCep = TextEditingController();
  final _tlogradouro = TextEditingController();
  final _tcomplemento = TextEditingController();
  final _tbairro = TextEditingController();
  final _tlocalidade = TextEditingController();
  final _tuf = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  bool _isEdited = false;
  Pessoa _pessoa;

  @override
  void initState() {
    super.initState();

    if (widget.pessoa == null) {
      _pessoa = Pessoa();
      _isEdited = false;
    } else {
      _pessoa = widget.pessoa;
      _isEdited = true;
      _tId.text = _pessoa.id.toString();
      _tNome.text = _pessoa.nome;
      _tCep.text = _pessoa.cep;
      _tlogradouro.text = _pessoa.logradouro;
      _tcomplemento.text = _pessoa.complemento;
      _tbairro.text = _pessoa.bairro;
      _tlocalidade.text = _pessoa.localidade;
      _tuf.text = _pessoa.uf;
    }
  }

  // PROCEDIMENTO PARA VALIDAR OS CAMPOS
  _validate(String text, String field) {
    if (text.isEmpty) {
      return "Digite $field";
    }
    return null;
  }

  // Widget EditText
  _editText(
      String field, TextEditingController controller, TextInputType type) {
    return TextFormField(
      controller: controller,
      validator: (s) => _validate(s, field),
      keyboardType: type,
      decoration: InputDecoration(
        labelText: field,
      ),
    );
  }

  Future _searchCep() async {
    // Defines the URL whit correct zip code
    final url = "https://viacep.com.br/ws/${_tCep.text}/json";

    // Creates a http Response type variable
    http.Response response;

    // Get the request and save in response var
    response = await http.get(url);

    Map<String, dynamic> result = json.decode(response.body);

    setState(() {
      _tlogradouro.text = result["logradouro"];
      _tcomplemento.text = result["complemento"];
      _tbairro.text = result["bairro"];
      _tlocalidade.text = result["localidade"];
      _tuf.text = result["uf"];
    });
  }

  @override
  Widget build(BuildContext context) {
    final _controller = Provider.of<PessoaController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Pessoa"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _editText("Nome", _tNome, TextInputType.text),

                // CEP
                TextFormField(
                  controller: _tCep,
                  validator: (s) => _validate(s, "Cep"),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Cep",
                  ),
                  onChanged: (text) {
                    _searchCep();
                  },
                ),

                _editText("Rua", _tlogradouro, TextInputType.text),
                _editText("Complemento", _tcomplemento, TextInputType.text),
                _editText("Bairro", _tbairro, TextInputType.text),
                _editText("Cidade", _tlocalidade, TextInputType.text),
                _editText("UF", _tuf, TextInputType.text),
                Container(
                  margin: EdgeInsets.only(top: 10.0, bottom: 20),
                  height: 45,
                  child: RaisedButton(
                    color: Colors.blue,
                    child: Text(
                      "Salvar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _pessoa.nome = _tNome.text;
                        _pessoa.cep = _tCep.text;
                        _pessoa.logradouro = _tlogradouro.text;
                        _pessoa.complemento = _tcomplemento.text;
                        _pessoa.bairro = _tbairro.text;
                        _pessoa.localidade = _tlocalidade.text;
                        _pessoa.uf = _tuf.text;

                        if (_isEdited) {
                          _controller.edit(_pessoa);
                        } else {
                          _pessoa.id = 0;
                          _controller.create(_pessoa);
                        }
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
                if (_isEdited)
                  Container(
                    margin: EdgeInsets.only(top: 5.0, bottom: 5),
                    height: 45,
                    child: RaisedButton(
                      color: Colors.red,
                      child: Text(
                        "Remover",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // return object of type Dialog
                              return AlertDialog(
                                title: new Text("Exclusão de Registro"),
                                content: new Text(
                                    "Tem certeza que deseja excluir este registro?"),
                                actions: <Widget>[
                                  // usually buttons at the bottom of the dialog
                                  FlatButton(
                                    child: new Text("Cancelar"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  FlatButton(
                                    child: new Text("Excluir"),
                                    onPressed: () {
                                      _controller.delete(_pessoa.id);
                                      Navigator.of(context).pop();
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
              ],
            ),
          )),
    );
  }
}
