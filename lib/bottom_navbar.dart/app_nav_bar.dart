import 'package:flutter/material.dart';

class AppNavBar extends StatefulWidget {
  const AppNavBar(
      {super.key,
      required this.currentIndex,
      required this.isLoggedIn,
      required this.onSelected});
  final bool isLoggedIn;
  final int currentIndex;
  final void Function(int) onSelected;

  @override
  State<AppNavBar> createState() => _AppNavBarState();
}

class _AppNavBarState extends State<AppNavBar> {
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
  @override
  void initState() {
    super.initState();
    debugPrint('$this initState with ${widget.isLoggedIn}');
  }

  @override
  void didUpdateWidget(covariant AppNavBar old) {
    super.didUpdateWidget(old);
    _maybeRemoveProfile();
  }

  _maybeRemoveProfile() {
    if (!widget.isLoggedIn) {
      items.removeLast();
    } else {
      items.add(const BottomNavigationBarItem(
          key: Key('Profile-BottomNavBar'),
          icon: Padding(
            padding: EdgeInsets.only(top: 20),
            child: CircleAvatar(
              child: Text('PR'),
            ),
          ),
          label: ''));
    }
  }

  @override
  Widget build(BuildContext context) {
    print('rebuild: ${widget.isLoggedIn}');
    return BottomNavigationBar(
        landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: widget.currentIndex,
        unselectedItemColor: Colors.black,
        selectedLabelStyle: TextStyle(color: Colors.blue),
        unselectedLabelStyle: TextStyle(color: Colors.black),
        selectedItemColor: Colors.black,
        items: items);
  }
}
