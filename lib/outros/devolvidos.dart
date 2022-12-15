import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:registros_notes/outros/add_emprestimos.dart';
import 'package:registros_notes/outros/edit_emprestimo.dart';

class Devolvidos extends StatefulWidget {
  String emprestimosKey;
  Devolvidos({this.emprestimosKey});
  @override
  __DevolvidosState createState() => __DevolvidosState();
}

class __DevolvidosState extends State<Devolvidos> {
  Query _ref;
  DatabaseReference reference =
      FirebaseDatabase.instance.reference().child('Emprestimos');

  DatabaseReference updateData;

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
    if (emprestimos['Stats'] == "Emprestado") {
      return Text('');
    }
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      height: 145,
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
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: 103,
              ),
              Container(
                  margin: EdgeInsets.all(10),
                  height: 30,
                  width: 180,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Devolvidos'),
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
}
