import 'package:example_buttons/bottom_navbar.dart/app_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int currentIndex = 0;
  void setCurrentIndex(int i) => setState(() => currentIndex = i);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Placeholder(
              child: Text('Page: ${currentIndex + 1}'),
            ),
            ElevatedButton(
                onPressed: () {
                  final isLoggedIn = ref.read(authProvider).isLoggedIn;
           
                  if (isLoggedIn && currentIndex == 3) {
                    setCurrentIndex(currentIndex - 1);
                  }
                  ref.read(authProvider.notifier).changeLogInStatus();
                },
                child: Text('Change logged in status'))
          ],
        ),
      ),
      bottomNavigationBar: ConsumerAppNavBar(
        currentIndex: currentIndex,
        onSelected: setCurrentIndex,
      ),
    );
  }
}
