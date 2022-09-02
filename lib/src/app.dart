import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:together_flutter/src/constants/color_constants.dart';
import 'package:together_flutter/src/controllers/app_controller.dart';
import 'package:together_flutter/src/pages/chat/chat_view.dart';
import 'package:together_flutter/src/pages/home/home_view.dart';
import 'package:together_flutter/src/pages/user_setting/setting_view.dart';

class App extends GetView<AppController> {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: _bodyView(),
          bottomNavigationBar: _bottomBar(),
        ));
  }

  Widget _bottomBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(.1),
          )
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12),
          child: GNav(
              selectedIndex: controller.currentIndex,
              onTabChange: (index) => controller.changeIndex(index),
              rippleColor:
                  Colors.grey[800]!, // tab button ripple color when pressed
              hoverColor: Colors.grey[700]!, // tab button hover color
              haptic: true, // haptic feedback
              tabBorderRadius: 15,
              duration:
                  const Duration(milliseconds: 10), // tab animation duration
              gap: 8, // the tab button gap between icon and text
              color: Colors.grey[800], // unselected icon color
              activeColor: subColor, // selected icon and text color
              iconSize: 24, // tab button icon size
              tabBackgroundColor:
                  subColor.withOpacity(0.1), // selected tab background color
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 5), // navigation bar padding
              tabs: const [
                GButton(
                  icon: LineIcons.home,
                  text: '홈',
                ),
                GButton(
                  icon: LineIcons.commentDots,
                  text: '채팅',
                ),
                GButton(
                  icon: LineIcons.usersCog,
                  text: '설정',
                )
              ]),
        ),
      ),
    );
  }

  Widget _bodyView() {
    switch (AppNavigator.values[controller.currentIndex]) {
      case AppNavigator.home:
        return const HomeView();
      case AppNavigator.chat:
        return const ChatView();
      default:
        return const SettingView();
    }
  }
}
