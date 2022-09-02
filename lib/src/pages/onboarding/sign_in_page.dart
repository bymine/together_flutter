import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:together_flutter/src/constants/color_constants.dart';
import 'package:together_flutter/src/constants/dimen_constants.dart';
import 'package:together_flutter/src/constants/reg_exp_constants.dart';
import 'package:together_flutter/src/controllers/onboarding/auth_controller.dart';
import 'package:together_flutter/src/widgets/input_widget.dart';

class SignInPage extends GetView<AuthController> {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar();
    double pageSize = MediaQuery.of(context).size.height;
    double notifySize = MediaQuery.of(context).padding.top;
    double appBarSize = appBar.preferredSize.height;
    return Scaffold(
      appBar: appBar,
      body: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          child: SizedBox(
            height: pageSize - (notifySize + appBarSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kHorizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "로그인",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: kLargeSpace,
                      ),
                      InputWidget(
                        textEditingController: controller.email,
                        title: "이메일",
                        hintText: "이메일 주소",
                        inputType: TextInputType.emailAddress,
                        validator: (email) {
                          if (email!.isEmpty) {
                            return "이메일을 입력하세요.";
                          } else if (!regExpEmail.hasMatch(email)) {
                            return "잘못된 이메일 형식입니다.";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: kLargeSpace,
                      ),
                      InputWidget(
                        textEditingController: controller.password,
                        obscureText: true,
                        title: "비밀번호",
                        hintText: "영문, 숫자, 특수문자 조합 8자리 이상",
                        inputType: TextInputType.visiblePassword,
                        validator: (password) {
                          if (password!.isEmpty) {
                            return "비밀번호를 입력하세요.";
                          } else if (!regExpPassword.hasMatch(password)) {
                            return "잘못된 비밀번호 형식입니다 (영문, 숫자, 특수문자 조합 8자리 이상)";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: kLargeSpace,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            flex: 1,
                            child: TextButton(
                              onPressed: () => Get.toNamed('/SignUp'),
                              child: const Text(
                                "회원가입",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: TextButton(
                              onPressed: () => Get.toNamed('/FindId'),
                              child: const Text(
                                "아이디찾기",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: TextButton(
                              onPressed: () => Get.toNamed('/FindPw'),
                              child: const Text(
                                "비밀번호찾기",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: background,
                      minimumSize: const Size(double.maxFinite, kButtonHeight),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero)),
                  onPressed: () {
                    controller.signIn();
                  },
                  child: const Text(
                    "로그인",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
