import 'package:app_web_papi/controllers/pessoa.controller.dart';
import 'package:app_web_papi/models/pessoa.model.dart';
import 'package:app_web_papi/views/pessoa_form.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../app_status.dart';

class PessoaListView extends StatefulWidget {
  @override
  _PessoaListViewState createState() => _PessoaListViewState();
}

class _PessoaListViewState extends State<PessoaListView> {
  @override
  Widget build(BuildContext context) {
    final _controller = Provider.of<PessoaController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Dexter Pizzaria 🍕"),
        centerTitle: true,
        backgroundColor: Colors.cyan[800],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showPessoaFormView();
        },
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await _controller.getAll();
        },
        child: Container(
          child: Observer(builder: (_) {
            if (_controller.status == AppStatus.loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (_controller.status == AppStatus.success) {
              return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: _controller.list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: Colors.grey[600],
                      child: ListTile(
                        leading: Icon(
                          Icons.account_circle,
                          color: Colors.white,
                          size: 40,
                        ),
                        title: Text(
                          _controller.list[index].nome,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        subtitle: Text(
                          _controller.list[index].localidade,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PessoaFormView(
                                  pessoa: _controller.list[index]),
                            ),
                          );
                        },
                      ),
                    );
                  });
            } else {
              return Text("${_controller.status.value}");
            }
          }),
        ),
      ),
      backgroundColor: Colors.grey[800],
    );
  }

  void _showPessoaFormView({Pessoa pessoa}) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PessoaFormView(
                  pessoa: pessoa,
                )));
  }
}
