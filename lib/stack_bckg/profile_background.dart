import 'package:example_buttons/extension/context_extensions.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){}),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      backgroundColor: Colors.pink,
      extendBody: true,
      extendBodyBehindAppBar: true,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
      ),
      body: SizedBox(
        height: context.height,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            DecoratedBox(
              decoration: const BoxDecoration(color: Color(0xff2900cd)),
              child: SizedBox(
                width: context.width,
                height: context.height * 0.4,
              ),
            ),
            Positioned(
              top: context.height * 0.1,
              child: Container(
                width: context.width * 0.8,
                height: context.availableHeight * 0.5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(1, 1),
                          spreadRadius: 0.5,
                          blurRadius: 5.9),
                    ]),
                child: const Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: CircleAvatar(
                        maxRadius: 45,
                        child: Icon(
                          Icons.person_2_outlined,
                          size: 50,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
