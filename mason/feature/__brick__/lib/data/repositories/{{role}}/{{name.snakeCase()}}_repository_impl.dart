{{#use_repository}}
import 'package:sukientotapp/domain/repositories/{{role}}/{{name.snakeCase()}}_repository.dart';

class {{name.pascalCase()}}RepositoryImpl implements {{name.pascalCase()}}Repository {
  // Implement repository methods here
}
{{/use_repository}}
{{^use_repository}}
// Delete this file if not used! I can't delete it automatically because of stupid windows file system
{{/use_repository}}