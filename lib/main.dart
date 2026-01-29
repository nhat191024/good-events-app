import 'package:get_storage/get_storage.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Import các file của bạn (giữ nguyên)
import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/core/utils/app_translations.dart';

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

  FThemeData _buildLightTheme() {
    final base = FThemes.zinc.light;
    return FThemeData(
      colors: base.colors.copyWith(
        primary: AppColors.red600,
        primaryForeground: AppColors.white,
        background: AppColors.lightBackground,
        foreground: AppColors.lightForeground,
        muted: AppColors.lightMuted,
        mutedForeground: AppColors.lightMutedForeground,
        border: AppColors.lightBorder,
        error: AppColors.error,
        destructive: AppColors.error,
        destructiveForeground: AppColors.white,
      ),
      typography: _buildTypography(base.typography),
      style: base.style,
    );
  }

  FThemeData _buildDarkTheme() {
    final base = FThemes.zinc.dark;
    return FThemeData(
      colors: base.colors.copyWith(
        primary: AppColors.red500,
        primaryForeground: AppColors.white,
        background: AppColors.darkBackground,
        foreground: AppColors.darkForeground,
        muted: AppColors.darkMuted,
        mutedForeground: AppColors.darkMutedForeground,
        border: AppColors.darkBorder,
        error: AppColors.error,
        destructive: AppColors.error,
        destructiveForeground: AppColors.white,
      ),
      typography: _buildTypography(base.typography),
      style: base.style,
    );
  }

  FTypography _buildTypography(FTypography base) {
    const fontFamily = 'Lexend';
    return base.copyWith(
      xs: base.xs.copyWith(fontFamily: fontFamily),
      sm: base.sm.copyWith(fontFamily: fontFamily),
      base: base.base.copyWith(fontFamily: fontFamily),
      lg: base.lg.copyWith(fontFamily: fontFamily),
      xl: base.xl.copyWith(fontFamily: fontFamily),
      xl2: base.xl2.copyWith(fontFamily: fontFamily),
      xl3: base.xl3.copyWith(fontFamily: fontFamily),
      xl4: base.xl4.copyWith(fontFamily: fontFamily),
      xl5: base.xl5.copyWith(fontFamily: fontFamily),
      xl6: base.xl6.copyWith(fontFamily: fontFamily),
      xl7: base.xl7.copyWith(fontFamily: fontFamily),
      xl8: base.xl8.copyWith(fontFamily: fontFamily),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lightTheme = _buildLightTheme();
    final darkTheme = _buildDarkTheme();

    return GetMaterialApp(
      initialRoute: Pages.initialRoute,
      getPages: Pages.routes,
      debugShowCheckedModeBanner: true,
      translations: AppTranslations(),
      locale: const Locale('vi', 'VN'),
      fallbackLocale: const Locale('en', 'US'),

      themeMode: ThemeMode.system,

      theme: ThemeData(
        fontFamily: 'Lexend',
        colorScheme: ColorScheme.light(
          primary: AppColors.red600,
          surface: AppColors.lightBackground,
          error: AppColors.error,
        ),
        scaffoldBackgroundColor: AppColors.lightBackground,
      ),
      darkTheme: ThemeData(
        fontFamily: 'Lexend',
        colorScheme: ColorScheme.dark(
          primary: AppColors.red500,
          surface: AppColors.darkBackground,
          error: AppColors.error,
        ),
        scaffoldBackgroundColor: AppColors.darkBackground,
      ),

      builder: (context, child) {
        final brightness = Theme.of(context).brightness;
        final theme = brightness == Brightness.dark ? darkTheme : lightTheme;

        return FTheme(data: theme, child: child!);
      },
    );
  }
}
