import 'package:sukientotapp/core/utils/import/global.dart';
{{#use_repository}}
import 'package:sukientotapp/domain/repositories/{{name.snakeCase()}}_repository.dart';
{{/use_repository}}
class {{name.pascalCase()}}Controller extends GetxController {
  {{#use_repository}}
  final {{name.pascalCase()}}Repository _repository;
  {{name.pascalCase()}}Controller(this._repository);
  {{/use_repository}}

  final isLoading = false.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  // }
}