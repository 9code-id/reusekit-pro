import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:reusekit/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Keep Flutter's default console output, then collect custom UI error logs.
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    flutterErrorHandler(details);
  };
  // await Supabase.initialize(
  //   url: Env.url,
  //   anonKey: Env.anonPublic,
  // );
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});
  @override
  State<MainApp> createState() => MainAppState();
}

class MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    GetIt.I.registerSingleton<MainAppState>(this);
  }

  List<Locale> supportedLocales = [
    Locale('en'),
    Locale('ko'),
    Locale('id'),
  ];

  void changeLocale(Locale locale) {
    setState(() {
      supportedLocales.clear();
      supportedLocales.add(locale);
    });
  }

  String get currentLocale {
    return supportedLocales.isNotEmpty
        ? supportedLocales.first.languageCode
        : 'en';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: RKAppTheme.theme.copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      debugShowCheckedModeBanner: false,
      locale: Locale(currentLocale),
      localizationsDelegates: const [
        FlutterQuillLocalizations.delegate,
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ko'),
        Locale('id'),
      ],
      home: AppView(),
    );
  }
}
