import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

import 'package:forui/forui.dart';

import 'package:stack_trace/stack_trace.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:sukientotapp/core/routes/pages.dart';

Future<void> main() async {
  Chain.capture(
    () async {
      // Ensure bindings are initialized
      WidgetsFlutterBinding.ensureInitialized();

      //package loading
      await dotenv.load();
      await GetStorage.init();

      runApp(const GoodEvent());
    },
    onError: (error, chain) {
      if (kDebugMode) {
        debugPrint('--- WE HAVE A FUKING PROBLEM ---');
        print(error);
        print(chain.terse);
        debugPrint('--- END OF FUKING PROBLEM ---');
      } else {
        //TODO: Report error to analytics service
      }
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
      debugShowCheckedModeBanner: false,
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
