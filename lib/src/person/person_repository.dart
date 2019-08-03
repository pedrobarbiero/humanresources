import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:humanresources/src/models/person_model.dart';
import 'package:rxdart/rxdart.dart';

class PersonRepository extends Disposable {
  CollectionReference _collection = Firestore.instance.collection('people');

  void add(Person person) => _collection.add(person.toMap());

  void update(String documentId, Person person) =>
      _collection.document(documentId).updateData(person.toMap());

  void delete(String documentId) => _collection.document(documentId).delete();

  Observable<List<Person>> get people =>
      Observable(_collection.snapshots().map((query) => query.documents
          .map<Person>((document) => Person.fromMap(document))
          .toList()));

  @override
  void dispose() {}
}
