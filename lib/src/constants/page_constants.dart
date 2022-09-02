import 'package:get/get.dart';
import 'package:together_flutter/src/app.dart';
import 'package:together_flutter/src/bindings/app_bindings.dart';
import 'package:together_flutter/src/bindings/project_bindings.dart';
import 'package:together_flutter/src/controllers/chat/chat_detail_controller.dart';
import 'package:together_flutter/src/controllers/file/add_file_controller.dart';
import 'package:together_flutter/src/controllers/file/detail_folder_controller.dart';
import 'package:together_flutter/src/controllers/home/add_project_controller.dart';
import 'package:together_flutter/src/controllers/home/show_project_controller.dart';
import 'package:together_flutter/src/controllers/onboarding/find_id_controller.dart';
import 'package:together_flutter/src/controllers/onboarding/find_pw_controller.dart';
import 'package:together_flutter/src/controllers/onboarding/sign_up_controller.dart';
import 'package:together_flutter/src/controllers/project_setting/edit_project_controller.dart';
import 'package:together_flutter/src/controllers/schedule/add_schedule_controller.dart';
import 'package:together_flutter/src/controllers/user_setting/edit_user_controller.dart';
import 'package:together_flutter/src/pages/chat/chat_detail_page.dart';
import 'package:together_flutter/src/pages/file/add_file_page.dart';
import 'package:together_flutter/src/pages/file/detail_folder_page.dart';
import 'package:together_flutter/src/pages/home/add_project_page.dart';
import 'package:together_flutter/src/pages/home/show_project_page.dart';
import 'package:together_flutter/src/pages/onboarding/find_id_page.dart';
import 'package:together_flutter/src/pages/onboarding/find_pw_page.dart';
import 'package:together_flutter/src/pages/onboarding/sign_in_page.dart';
import 'package:together_flutter/src/pages/onboarding/sign_up_page.dart';
import 'package:together_flutter/src/pages/onboarding/splash_screen.dart';
import 'package:together_flutter/src/pages/project_page.dart';
import 'package:together_flutter/src/pages/project_setting/edit_profile_page.dart';
import 'package:together_flutter/src/pages/schedule/add_schedule_page.dart';
import 'package:together_flutter/src/pages/user_setting/edit_account_page.dart';
import 'package:together_flutter/src/pages/user_setting/edit_setting_profile_page.dart';

List<GetPage<dynamic>> pages = [
  // onboarding
  GetPage(name: '/', page: () => const SplashScreen()),
  GetPage(name: '/SignIn', page: () => const SignInPage()),
  GetPage(
      name: '/SignUp',
      page: () => const SignUpPage(),
      binding: BindingsBuilder.put(() => SignUpController())),
  GetPage(
      name: '/FindId',
      page: () => const FindIdPage(),
      binding: BindingsBuilder.put(() => FindIdController())),
  GetPage(
      name: '/FindPw',
      page: () => const FindPwPage(),
      binding: BindingsBuilder.put(() => FindPwController())),

  GetPage(
    name: '/App',
    page: () => const App(),
    binding: AppBindings(),
  ),

  // Home
  GetPage(
      name: '/AddProject',
      page: () => const AddProjectPage(),
      binding: BindingsBuilder.put(() => AddProjectController())),

  GetPage(
      name: '/ShowProject',
      page: () => const ShowProjectPage(),
      binding: BindingsBuilder.put(() => ShowProjectController())),

  GetPage(
      name: '/MainProject',
      page: () => const MainProjectPage(),
      binding: ProjectBindings()),

  // Schedule
  GetPage(
      name: '/AddSchedule',
      page: () => const AddSchedulePage(),
      binding: BindingsBuilder.put(() => AddScheduleController())),

  // File
  GetPage(
      name: '/AddFile',
      page: () => const AddFilePage(),
      binding: BindingsBuilder.put(() => AddFileController())),
  GetPage(
      name: '/DetailFolder',
      page: () => const DetailFolderPage(),
      binding: BindingsBuilder.put(() => DetailFolderController())),

  // ProjectSetting
  GetPage(
    name: '/EditProject',
    page: () => const EditProjectPage(),
    binding: BindingsBuilder.put(() => EditProjectController()),
  ),

  // Chat
  GetPage(
      name: '/ChatDetail',
      page: () => const ChatDetailPage(),
      binding: BindingsBuilder.put(() => ChatDetailController())),

  // Setting
  GetPage(
      name: '/EditUser',
      page: () => const EditSettingUserProfilePage(),
      binding: BindingsBuilder.put(() => EditUserController())),

  GetPage(
    name: '/EditAccount',
    page: () => const EditAccountPage(),
  ),
];
