import 'package:flutter/material.dart';

import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

import 'package:forui/forui.dart';

import 'package:stack_trace/stack_trace.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:sukientotapp/core/routes/pages.dart';

void main() {
  Chain.capture(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      FlutterError.onError = (FlutterErrorDetails details) {
        final terseTrace = Trace.from(details.stack!).terse;
        debugPrint('--- WE HAVE FUKIN PROBLEM ---');
        debugPrint(terseTrace.toString());
      };

      await dotenv.load();
      await GetStorage.init();

      runApp(const GoodEvent());
    },
    onError: (error, stackChain) {
      debugPrint('--- ASYNCHRONOUS IS FKED ---');
      debugPrint('Error: $error');
      debugPrint(stackChain.terse.toString());
    },
  );
}

class GoodEvent extends StatelessWidget {
  const GoodEvent({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: Pages.initialRoute,
      getPages: Pages.routes,
      debugShowCheckedModeBanner: true,
      theme: FThemeData(
        colors: FThemes.rose.light.colors,
        typography: FThemes.rose.light.typography.copyWith(
          xs: const TextStyle(fontFamily: 'Lexend'),
        ),
      ).toApproximateMaterialTheme(),
      builder: (context, child) {
        return FTheme(data: FThemes.rose.light, child: child!);
      },
    );
  }
}
