import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:humanresources/src/person/person_bloc.dart';
import 'package:intl/intl.dart';

class PersonPage extends StatelessWidget {
  var _bloc = PersonBloc();
  var _dateFormat = DateFormat("dd/MM/yyyy");
  var _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Human Resources"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              StreamBuilder(
                stream: _bloc.outName,
                initialData: "",
                builder: (context, snapshot) {
                  return Container(
                    child: TextField(
                      controller: _nameController,
                      onChanged: (value) {
                        _bloc.setName(value);
                      },
                      decoration: InputDecoration(labelText: "Nome"),
                    ),
                  );
                },
              ),
              Container(height: 20),
              StreamBuilder<DateTime>(
                stream: _bloc.outBirthDate,
                initialData: DateTime.now(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Container();

                  return InkWell(
                    onTap: () => _selectBirthDate(context, snapshot.data),
                    child: InputDecorator(
                      decoration:
                          InputDecoration(labelText: "Data de Nascimento"),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(_dateFormat.format(snapshot.data)),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Container(height: 20),
              StreamBuilder(
                stream: _bloc.outActive,
                initialData: true,
                builder: (context, snapshot) {
                  return Column(
                    children: <Widget>[
                      Text(
                        "Ativo",
                        textAlign: TextAlign.start,
                        style: TextStyle(),
                      ),
                      Center(
                        child: Switch(
                          value: snapshot.data,
                          onChanged: (value) {
                            _bloc.setActive(value);
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _selectBirthDate(BuildContext context, DateTime initialDate) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2101));
    if (picked != null) {
      _bloc.setBirthDate(picked);
    }
  }
}
