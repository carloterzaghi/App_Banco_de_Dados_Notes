import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:registros_notes/outros/add_emprestimos.dart';
import 'package:registros_notes/outros/edit_emprestimo.dart';
import 'devolvidos.dart';

class Emprestimos extends StatefulWidget {
  String emprestimosKey;
  Emprestimos({this.emprestimosKey});
  @override
  __EmprestimosState createState() => __EmprestimosState();
}

class __EmprestimosState extends State<Emprestimos> {
  Query _ref;
  DatabaseReference reference =
      FirebaseDatabase.instance.reference().child('Emprestimos');

  DatabaseReference updateData;

  var _devolvido = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ref = FirebaseDatabase.instance
        .reference()
        .child('Emprestimos')
        .orderByChild('name');
    updateData = FirebaseDatabase.instance.reference().child('Emprestimos');
  }

  Widget _buildEmprestimoItem({Map emprestimos}) {
    if (emprestimos['Stats'] == 'Devolvido') {
      return Text('');
    }
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      height: 150,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.person,
                color: Theme.of(context).primaryColor,
                size: 20,
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                emprestimos['Nome'],
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.computer,
                color: Theme.of(context).accentColor,
                size: 20,
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                emprestimos['Notebook'],
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                emprestimos['Stats'],
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Icon(
                Icons.badge,
                color: Theme.of(context).accentColor,
                size: 20,
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                emprestimos['Matricula'],
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: 150,
              ),
              Icon(
                Icons.access_time,
                color: Theme.of(context).accentColor,
                size: 20,
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                emprestimos['Tempo'],
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            children: [
              Container(
                  margin: EdgeInsets.all(10),
                  height: 35,
                  width: 110,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: FlatButton(
                    child: Text(
                      'Entregue',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    onPressed: () {
                      _entregarNoteBook(emprestimos: emprestimos);
                    },
                  )),
              SizedBox(
                width: 5,
              ),
              Container(
                  margin: EdgeInsets.all(10),
                  height: 35,
                  width: 110,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: FlatButton(
                    child: Text(
                      'Editar',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => EditEmprestimos(
                                    emprestimosKey: emprestimos['key'],
                                  )));
                    },
                  )),
              SizedBox(
                width: 5,
              ),
              Container(
                  margin: EdgeInsets.all(10),
                  height: 35,
                  width: 110,
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: FlatButton(
                    child: Text(
                      'Delete',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    onPressed: () {
                      _showDeleteEmprestimo(emprestimos: emprestimos);
                    },
                  )),
            ],
          ),
        ],
      ),
    );
  }

  _showDeleteEmprestimo({Map emprestimos}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Entregar ${emprestimos['Nome']}'),
            content: Text('Certeza que quer salvar?'),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancelar')),
              FlatButton(
                  onPressed: () {
                    reference
                        .child(emprestimos['key'])
                        .remove()
                        .whenComplete(() => Navigator.pop(context));
                  },
                  child: Text('Deletar'))
            ],
          );
        });
  }

  _entregarNoteBook({Map emprestimos}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Entregar ${emprestimos['Nome']}'),
            content: Text('Certeza que quer salvar?'),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancelar')),
              FlatButton(
                  onPressed: () {
                    reference
                        .child(emprestimos['key'])
                        .update({'Stats': 'Devolvido'}).whenComplete(
                            () => Navigator.pop(context));
                  },
                  child: Text('Entregar'))
            ],
          );
        });
  }

  bool updateprato(
    String chave,
  ) {
    bool stat = false;

    updateData
        .child(widget.emprestimosKey)
        .child(chave)
        .update({'Stats': 'Devolvido'});
    stat = true;

    return stat;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Empréstimos'),
      ),
      body: Container(
        height: double.infinity,
        child: FirebaseAnimatedList(
          query: _ref,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map emprestimos = snapshot.value;
            emprestimos['key'] = snapshot.key;
            return _buildEmprestimoItem(emprestimos: emprestimos);
          },
        ),
      ),
    );
  }

  void entregarNoteBook() {
    updateData.child(widget.emprestimosKey).update({'Stats': 'Devolvido'});
  }
}
