import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:humanresources/src/app_module.dart';
import 'package:humanresources/src/person/person_repository.dart';

class PersonBloc extends BlocBase {
  var _repository = AppModule.to.getDependency<PersonRepository>();
  get people => _repository.people;

  @override
  void dispose() {
    super.dispose();
  }
}
