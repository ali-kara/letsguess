import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:letsguess/app/data/app_colors.dart';
import 'package:letsguess/app/providers/theme_provider.dart';
import 'package:letsguess/app/providers/audio_provider.dart';
import 'package:letsguess/app/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('tr'), Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('tr'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AudioProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          final baseDark = ThemeData.dark();
          final baseLight = ThemeData.light();

          final lightTheme = baseLight.copyWith(
            colorScheme: baseLight.colorScheme.copyWith(
              primary: AppColors.primary,
              secondary: AppColors.secondary,
              surface: AppColors.lightSurface,
              background: AppColors.lightBackground,
            ),
            scaffoldBackgroundColor: AppColors.lightBackground,
            textTheme: GoogleFonts.poppinsTextTheme(baseLight.textTheme),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
            ),
          );

          final darkTheme = baseDark.copyWith(
            colorScheme: baseDark.colorScheme.copyWith(
              primary: AppColors.primary,
              secondary: AppColors.secondary,
              surface: AppColors.darkSurface,
              background: AppColors.darkBackground,
            ),
            scaffoldBackgroundColor: AppColors.darkBackground,
            textTheme: GoogleFonts.poppinsTextTheme(baseDark.textTheme)
                .apply(bodyColor: Colors.white, displayColor: Colors.white),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
            ),
          );

          return MaterialApp(
            title: 'Lets Guess',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeProvider.themeMode,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            routes: Routes.getRoutes(),
          );
        },
      ),
    );
  }
}
