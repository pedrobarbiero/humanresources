import 'package:flutter/material.dart';
import 'package:humanresources/src/models/person_model.dart';
import 'package:humanresources/src/person/person_bloc.dart';
import 'package:humanresources/src/person/person_page.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  var _bloc = PersonBloc();
  var _dateFormat = DateFormat("dd/MM/yyyy");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Human Resources"),
      ),
      body: Container(
        child: StreamBuilder<List<Person>>(
          stream: _bloc.people,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();

            return Container(
              child: ListView(
                children: snapshot.data.map((person) {
                  return ListTile(
                    title: Text(person.name),
                    subtitle: Text(_dateFormat.format(person.birthDate)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PersonPage()),
                      );
                    },
                  );
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
