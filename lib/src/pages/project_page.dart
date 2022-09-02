import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:together_flutter/src/constants/color_constants.dart';
import 'package:together_flutter/src/controllers/app_controller.dart';
import 'package:together_flutter/src/controllers/project_controller.dart';
import 'package:together_flutter/src/pages/file/file_view.dart';
import 'package:together_flutter/src/pages/project_setting/project_setting_view.dart';
import 'package:together_flutter/src/pages/schedule/schedule_view.dart';

class MainProjectPage extends GetView<ProjectController> {
  const MainProjectPage({Key? key}) : super(key: key);

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
                  icon: LineIcons.calendar,
                  text: '일정',
                ),
                GButton(
                  icon: LineIcons.file,
                  text: '파일',
                ),
                GButton(
                  icon: LineIcons.cog,
                  text: '설정',
                )
              ]),
        ),
      ),
    );
  }

  Widget _bodyView() {
    switch (ProjectNavigator.values[controller.currentIndex]) {
      case ProjectNavigator.schedule:
        return const ScheduleView();
      case ProjectNavigator.file:
        return const FileView();
      default:
        return const ProjectSettingView();
    }
  }
}
