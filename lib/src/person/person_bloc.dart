import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:humanresources/src/app_module.dart';
import 'package:humanresources/src/person/person_repository.dart';
import 'package:rxdart/rxdart.dart';

class PersonBloc extends BlocBase {
  var _repository = AppModule.to.getDependency<PersonRepository>();
  get people => _repository.people;

  var _birthDateController = BehaviorSubject<DateTime>();
  Stream<DateTime> get outBirthDate => _birthDateController.stream;

  var _nameController = BehaviorSubject<String>();
  Stream<String> get outName => _nameController.stream;

  var _activeController = BehaviorSubject<bool>();
  Stream<bool> get outActive => _activeController.stream;

  void setBirthDate(DateTime value) {
    _birthDateController.sink.add(value);
  }

  void setActive(bool value) {
    _activeController.sink.add(value);
  }

  void setName(String value) {
    _nameController.sink.add(value);
  }

  @override
  void dispose() {
    _birthDateController.close();
    _activeController.close();
    _nameController.close();
    super.dispose();
  }
}
