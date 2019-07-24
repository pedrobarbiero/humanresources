import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:humanresources/src/models/person_model.dart';
import 'package:rxdart/rxdart.dart';

class PersonRepository extends Disposable {
  CollectionReference _collection = Firestore.instance.collection('people');

  void add(Person person){
    _collection.add(person.toMap());
  }

  Observable<List<Person>> get people =>
      Observable(_collection.snapshots().map((query) => query.documents
          .map<Person>((document) => Person.fromMap(document.data))
          .toList()));

  @override
  void dispose() {}
}
