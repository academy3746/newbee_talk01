// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newbee_talk/common/utils/back_handler_button.dart';
import 'package:newbee_talk/features/main/widgets/chat.dart';
import 'package:newbee_talk/features/main/widgets/index.dart';
import 'package:newbee_talk/features/main/widgets/user_info.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const String routeName = '/main';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  /// 뒤로가기 처리
  BackHandlerButton? backHandlerButton;

  /// Selected Index No.
  int screenIndex = 0;

  /// Footer
  final List<Widget> _screens = [
    const IndexScreen(),
    const ChatScreen(),
    const InfoScreen(),
  ];

  @override
  void initState() {
    super.initState();

    backHandlerButton = BackHandlerButton(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (backHandlerButton != null) {
          return backHandlerButton!.onWillPop();
        }

        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _screens.elementAt(screenIndex),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: screenIndex,
          backgroundColor: Theme.of(context).primaryColor,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black45,
          onTap: (index) {
            setState(() {
              screenIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.house),
              label: 'HOME',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.comments),
              label: 'CHAT',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.user),
              label: 'INFO',
            ),
          ],
        ),
      ),
    );
  }
}
