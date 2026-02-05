import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:forui/forui.dart';
import 'controller.dart';

class {{name.pascalCase()}}View extends  GetView<{{name.pascalCase()}}Controller> {
  const {{name.pascalCase()}}View({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(title: Text('{{name.pascalCase()}}'),),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text('{{name.pascalCase()}} Module')]),
    );
  }
}