import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:together_flutter/src/constants/color_constants.dart';
import 'package:together_flutter/src/constants/dimen_constants.dart';
import 'package:together_flutter/src/constants/reg_exp_constants.dart';
import 'package:together_flutter/src/controllers/onboarding/find_pw_controller.dart';
import 'package:together_flutter/src/widgets/input_widget.dart';

class FindPwPage extends GetView<FindPwController> {
  const FindPwPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar();
    double pageSize = MediaQuery.of(context).size.height;
    double notifySize = MediaQuery.of(context).padding.top;
    double appBarSize = appBar.preferredSize.height;
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: SizedBox(
          height: pageSize - (notifySize + appBarSize),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: kHorizontalPadding,
                      right: kHorizontalPadding,
                      top: kHorizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "비밀번호 찾기",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      InputWidget(
                        textEditingController: controller.email,
                        title: "아이디",
                        mode: AutovalidateMode.onUserInteraction,
                        hintText: "이메일을 입력하세요",
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
                        height: 50,
                      ),
                      InputWidget(
                        textEditingController: controller.name,
                        title: "이름",
                        mode: AutovalidateMode.onUserInteraction,
                        hintText: "본명을 입력해 주세요",
                        validator: (name) {
                          if (name!.isEmpty) {
                            return "이름을 입력하세요.";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      InputWidget(
                        mode: AutovalidateMode.onUserInteraction,
                        textEditingController: controller.birth,
                        inputType: TextInputType.number,
                        title: "생년월일",
                        hintText: "YYYYMMDD",
                        validator: (birth) {
                          if (birth!.isEmpty) {
                            return "생년월일 입력하세요.";
                          } else if (!regExpBirth.hasMatch(birth)) {
                            return "잘못된 생년월일 형식입니다";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      InputWidget(
                          textEditingController: controller.phone,
                          inputType: TextInputType.phone,
                          title: "휴대전화 번호 인증",
                          mode: AutovalidateMode.onUserInteraction,
                          hintText: "휴대전화 번호(숫자만)",
                          validator: (phone) {
                            if (phone!.isEmpty) {
                              return "휴대전화 번호을 입력하세요.";
                            } else if (!regExpPhone.hasMatch(phone)) {
                              return "잘못된 휴대전화 형식 입니다";
                            }
                            return null;
                          },
                          button: InkWell(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(color: subColor)),
                              child: const Text(
                                "인증받기",
                                style: TextStyle(fontSize: 10, color: subColor),
                              ),
                            ),
                          )),
                      Obx(
                        () => Visibility(
                          visible: controller.phoneAuth.value,
                          child: InputWidget(
                              textEditingController: controller.code,
                              inputType: TextInputType.phone,
                              mode: AutovalidateMode.onUserInteraction,
                              hintText: "인증코드",
                              validator: (phone) {
                                if (phone!.isEmpty) {
                                  return "인증 번호을 입력하세요.";
                                }
                                return null;
                              },
                              button: InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(color: subColor)),
                                  child: const Text(
                                    "인증확인",
                                    style: TextStyle(
                                        fontSize: 10, color: subColor),
                                  ),
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
