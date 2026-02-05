{{#use_repository}}
abstract class {{name.pascalCase()}}Repository {
  // Future<Either<Failure, Data>> get{{name.pascalCase()}}Data();
}
{{/use_repository}}
{{^use_repository}}
// Delete this file if not used! I can't delete it automatically because of stupid windows file system
{{/use_repository}}