import 'package:example_buttons/buttons/action_button.dart';
import 'package:example_buttons/extension/context_extensions.dart';
import 'package:example_buttons/mixin/widget_state_property.dart';
import 'package:example_buttons/stack_bckg/profile_background.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget with WidgetStatePropertyMixin {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    const env = String.fromEnvironment('ENVIRONMENT');
    const baseurl = String.fromEnvironment('BASE_URL');
    const authapi = String.fromEnvironment('AUTH_API');
    const citas = String.fromEnvironment('CITAS_API');
    return MaterialApp(
      home: true ? ProfileScreen() : Scaffold(
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
      ),
    );
  }
}
