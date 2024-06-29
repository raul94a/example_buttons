import 'package:example_buttons/bottom_navbar.dart/app_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MyWidget has a title and message', (tester) async {
    // Create the widget by telling the tester to build it.
    const app = AppEntry(home: TestNavBarW());
    await tester.pumpWidget(app);

    final navBar = find.byType(AppNavBar);

    expect(navBar, findsOneWidget);

    var profileNavBarAvatar = findProfileItem(find);

    expect(profileNavBarAvatar, findsOne);

    final elevatedButton = find.byType(ElevatedButton);

    expect(elevatedButton, findsOneWidget);

    // onPressed elevated button
    await tester.tap(elevatedButton);
    await tester.pump(const Duration(milliseconds: 1000));
    profileNavBarAvatar = findProfileItem(find);
    expect(profileNavBarAvatar, findsNothing);
    await tester.tap(elevatedButton);
    await tester.pump(const Duration(milliseconds: 1000));

    profileNavBarAvatar = findProfileItem(find);
    expect(profileNavBarAvatar, findsOne);
  });
}

Finder findProfileItem(CommonFinders find) {
  return find.byKey(const Key('Profile-BottomNavBar'));
}

class TestNavBarW extends StatefulWidget {
  const TestNavBarW({super.key});

  @override
  State<TestNavBarW> createState() => _TestNavBarWState();
}

class _TestNavBarWState extends State<TestNavBarW> {
  bool isLoggedIn = true;
  setLoginFalse() => setState(() => isLoggedIn = !isLoggedIn);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.topCenter,
        children: [
          ElevatedButton(
              onPressed: () {
                debugPrint('Calling setLoginFalse');
                setLoginFalse();
                debugPrint('isLoggedIn: $isLoggedIn');
              },
              child: const Text('Disable profile'))
        ],
      ),
      bottomNavigationBar: AppNavBar(
          currentIndex: 0, isLoggedIn: isLoggedIn, onSelected: (_) {}),
    );
  }
}

class AppEntry extends StatelessWidget {
  const AppEntry({super.key, required this.home});
  final Widget home;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: home,
    );
  }
}
