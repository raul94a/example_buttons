import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthState {
  final bool isLoggedIn;
  AuthState({
    required this.isLoggedIn,
  });

  AuthState copyWith({
    bool? isLoggedIn,
  }) {
    return AuthState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(super._state);

  void changeLogInStatus() =>
      state = state.copyWith(isLoggedIn: !state.isLoggedIn);
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(AuthState(isLoggedIn: true));
});

class ConsumerAppNavBar extends ConsumerWidget {
  const ConsumerAppNavBar({
    super.key,
    required this.onSelected,
    required this.currentIndex,
  });

  final void Function(int) onSelected;
  final int currentIndex;

  @override
  Widget build(BuildContext context, ref) {
    final isLoggedIn =
        ref.watch(authProvider.select((state) => state.isLoggedIn));

    var items = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Cit.'),
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Med.'),
      const BottomNavigationBarItem(
          key: Key('Profile-BottomNavBar'),
          icon: Padding(
            padding: EdgeInsets.only(top: 20),
            child: CircleAvatar(
              child: Text('PR'),
            ),
          ),
          label: ''),
    ];
    if (!isLoggedIn) {
      items.removeLast();
    }
    return AppNavBar(
      items: items,
      currentIndex: currentIndex,
      onSelected: onSelected,
    );
  }
}

class AppNavBar extends StatefulWidget {
  const AppNavBar(
      {super.key,
      required this.currentIndex,
      required this.onSelected,
      required this.items});

  final int currentIndex;
  final void Function(int) onSelected;
  final List<BottomNavigationBarItem> items;

  @override
  State<AppNavBar> createState() => _AppNavBarState();
}

class _AppNavBarState extends State<AppNavBar> {
  BottomNavigationBarItem getProfile() {
    return const BottomNavigationBarItem(
        key: Key('Profile-BottomNavBar'),
        icon: Padding(
          padding: EdgeInsets.only(top: 20),
          child: CircleAvatar(
            child: Text('PR'),
          ),
        ),
        label: '');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AppNavBar old) {
    super.didUpdateWidget(old);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: widget.currentIndex,
        onTap: widget.onSelected,
        unselectedItemColor: Colors.black,
        selectedLabelStyle: TextStyle(color: Colors.blue),
        unselectedLabelStyle: TextStyle(color: Colors.black),
        selectedItemColor: Colors.black,
        items: widget.items);
  }
}
