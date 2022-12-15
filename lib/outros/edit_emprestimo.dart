import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:registros_notes/outros/emprestimos.dart';

class EditEmprestimos extends StatefulWidget {
  String emprestimosKey;
  EditEmprestimos({this.emprestimosKey});
  @override
  __EditEmprestimosState createState() => __EditEmprestimosState();
}

class __EditEmprestimosState extends State<EditEmprestimos> {
  TextEditingController _nameController,
      _numberController,
      _tempoController,
      _notebookController;

  DatabaseReference _ref;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = TextEditingController();
    _numberController = TextEditingController();
    _tempoController = TextEditingController();
    _notebookController = TextEditingController();
    _ref = FirebaseDatabase.instance.reference().child('Emprestimos');
    getEmprestimoDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Empréstimo'),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                  hintText: 'Nome',
                  prefixIcon: Icon(
                    Icons.account_circle,
                    size: 30,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(15)),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: _numberController,
              decoration: InputDecoration(
                  hintText: 'Matrícula',
                  prefixIcon: Icon(
                    Icons.badge,
                    size: 30,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(15)),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: _notebookController,
              decoration: InputDecoration(
                  hintText: 'Número do NoteBook',
                  prefixIcon: Icon(
                    Icons.computer,
                    size: 30,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(15)),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: _tempoController,
              decoration: InputDecoration(
                  hintText: 'Tempo de uso',
                  prefixIcon: Icon(
                    Icons.access_time,
                    size: 30,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(15)),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: RaisedButton(
                child: Text(
                  'Update',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                onPressed: () {
                  saveEmprestimo();
                },
                color: Theme.of(context).primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }

  getEmprestimoDetail() async {
    DataSnapshot snapshot = await _ref.child(widget.emprestimosKey).once();

    Map emprestimos = snapshot.value;

    _nameController.text = emprestimos['Nome'];
    _numberController.text = emprestimos['Matricula'];
    _notebookController.text = emprestimos['Notebook'];
    _tempoController.text = emprestimos['Tempo'];
  }

  void saveEmprestimo() {
    String name = _nameController.text;
    String sid = _numberController.text;
    String notebook = _notebookController.text;
    String time = _tempoController.text;

    Map<String, String> emprestimo = {
      'Nome': name,
      'Matricula': sid,
      'Notebook': notebook,
      'Tempo': time,
      'Stats': 'Emprestado',
    };
    _ref.child(widget.emprestimosKey).update(emprestimo).then((value) {
      Navigator.pop(context);
    });
  }
}
