import 'package:example_buttons/bottom_navbar.dart/app_nav_bar.dart';
import 'package:example_buttons/bottom_navbar.dart/home_screen.dart';
import 'package:example_buttons/buttons/action_button.dart';
import 'package:example_buttons/custom_calendar/custom_calendar.dart';
import 'package:example_buttons/extension/context_extensions.dart';
import 'package:example_buttons/mixin/widget_state_property.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget with WidgetStatePropertyMixin {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('en', 'GB'),
      ],
      home: false
          ? Scaffold(
            appBar: AppBar(),
            body: CustomWeekCalendar(
                firstDate: DateTime(2000),
                lastDate: DateTime(DateTime.now().year + 20),
                onSelectedDate: (p0) {},
              ),
          )
          : const MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget with WidgetStatePropertyMixin {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const env = String.fromEnvironment('ENVIRONMENT');
    const baseurl = String.fromEnvironment('BASE_URL');
    const authapi = String.fromEnvironment('AUTH_API');
    const citas = String.fromEnvironment('CITAS_API');
    return  true ? const HomeScreen()  : Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        children: [
          const Text(env),
          const Text(baseurl),
          const Text(authapi),
          const Text(citas),
          ActionButton(
              text: 'Consulta',
              textStyle: context.bodyMedium.copyWith(color: Colors.white),
              buttonStyle: ButtonStyle(
                  fixedSize: getProperty(Size(context.width * 0.5, 50))),
              gradient: const LinearGradient(
                  colors: [Colors.purple, Colors.deepPurple]),
              onPressed: () async {
                await Future.delayed(const Duration(seconds: 1));
              }),
          ActionButton(text: 'Censo', onPressed: () {})
        ],
      )),
    );
  }
}


