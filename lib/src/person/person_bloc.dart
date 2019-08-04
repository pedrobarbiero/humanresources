import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:humanresources/src/app_module.dart';
import 'package:humanresources/src/models/person_model.dart';
import 'package:humanresources/src/person/person_repository.dart';
import 'package:rxdart/rxdart.dart';

class PersonBloc extends BlocBase {
  String _name;
  DateTime _birthDate;
  bool _active;
  String _documentId;

  PersonBloc() {
    _birthDateController.listen((value) => _birthDate = value);
    _nameController.listen((value) => _name = value);
    _activeController.listen((value) => _active = value);
  }

  var _repository = AppModule.to.getDependency<PersonRepository>();

  void setPerson(Person person) {
    _documentId = person.documentId();
    setName(person.name);
    setActive(person.active);
    setBirthDate(person.birthDate);
  }

  var _birthDateController = BehaviorSubject<DateTime>();
  Stream<DateTime> get outBirthDate => _birthDateController.stream;

  var _nameController = BehaviorSubject<String>();
  Stream<String> get outName => _nameController.stream;

  var _activeController = BehaviorSubject<bool>();
  Stream<bool> get outActive => _activeController.stream;

  void setBirthDate(DateTime value) => _birthDateController.sink.add(value);

  void setActive(bool value) => _activeController.sink.add(value);

  void setName(String value) => _nameController.sink.add(value);

  bool insertOrUpdate() {
    var person = Person()
      ..name = _name
      ..birthDate = _birthDate
      ..active = _active;

    if (_documentId?.isEmpty ?? true) {
      _repository.add(person);
    } else {
      _repository.update(_documentId, person);
    }

    return true;
  }

  @override
  void dispose() {
    _birthDateController.close();
    _activeController.close();
    _nameController.close();
    super.dispose();
  }
}
