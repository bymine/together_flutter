import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:together_flutter/src/constants/color_constants.dart';
import 'package:together_flutter/src/constants/dimen_constants.dart';
import 'package:together_flutter/src/constants/reg_exp_constants.dart';
import 'package:together_flutter/src/controllers/onboarding/sign_up_controller.dart';
import 'package:together_flutter/src/widgets/input_widget.dart';

class SignUpPage extends GetView<SignUpController> {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("회원가입"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: controller.formKey,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: kHorizontalPadding, vertical: kMiddleSpace),
                child: Column(
                  children: [
                    InputWidget(
                      textEditingController: controller.email,
                      title: "아이디",
                      hintText: "이메일을 입력하세요",
                      inputType: TextInputType.emailAddress,
                      mode: AutovalidateMode.onUserInteraction,
                      validator: (email) {
                        if (email!.isEmpty) {
                          return "이메일을 입력하세요.";
                        } else if (!regExpEmail.hasMatch(email)) {
                          return "잘못된 이메일 형식입니다.";
                        }
                        return null;
                      },
                      onEditingComplete: () => FocusScope.of(context)
                          .requestFocus(controller.passwordFocusNode),
                    ),
                    const SizedBox(
                      height: kMiddleSpace,
                    ),
                    InputWidget(
                      textEditingController: controller.password,
                      title: "비밀번호",
                      obscureText: true,
                      inputType: TextInputType.visiblePassword,
                      hintText: "영문, 숫자, 특수문자 조합 8자리 이상",
                      mode: AutovalidateMode.onUserInteraction,
                      focusNode: controller.passwordFocusNode,
                      onEditingComplete: () => FocusScope.of(context)
                          .requestFocus(controller.passwordFocusNode),
                      validator: (password) {
                        if (password!.isEmpty) {
                          return "비밀번호을 입력하세요.";
                        } else if (!regExpPassword.hasMatch(password)) {
                          return "잘못된 비밀번호 형식입니다 (영문, 숫자, 특수문자 조합 8자리 이상)";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: kSmallSpace,
                    ),
                    InputWidget(
                      textEditingController: controller.rePassword,
                      hintText: "비밀번호 재입력",
                      obscureText: true,
                      inputType: TextInputType.visiblePassword,
                      mode: AutovalidateMode.onUserInteraction,
                      focusNode: controller.rePasswordFocusNode,
                      onEditingComplete: () => FocusScope.of(context)
                          .requestFocus(controller.nameFocusNode),
                      validator: (rePassword) {
                        if (rePassword!.isEmpty) {
                          return "비밀번호 재입력을 입력하세요.";
                        } else if (controller.password.text != rePassword) {
                          return "비밀번호가 일치하지 않습니다";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: kMiddleSpace,
                    ),
                    InputWidget(
                      textEditingController: controller.name,
                      title: "이름",
                      hintText: "본명을 입력하세요",
                      mode: AutovalidateMode.onUserInteraction,
                      focusNode: controller.nameFocusNode,
                      onEditingComplete: () => FocusScope.of(context)
                          .requestFocus(controller.birthFocusNode),
                      validator: (name) {
                        if (name!.isEmpty) {
                          return "이름을 입력하세요.";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: kMiddleSpace,
                    ),
                    InputWidget(
                      textEditingController: controller.birth,
                      title: "생년월일",
                      hintText: "YYYYMMDD",
                      inputType: TextInputType.number,
                      mode: AutovalidateMode.onUserInteraction,
                      focusNode: controller.birthFocusNode,
                      onEditingComplete: () => FocusScope.of(context)
                          .requestFocus(controller.phoneFocusNode),
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
                      height: kMiddleSpace,
                    ),
                    InputWidget(
                      textEditingController: controller.phone,
                      title: "휴대폰 번호",
                      inputType: TextInputType.number,
                      hintText: "휴대폰 번호 (숫자만)",
                      mode: AutovalidateMode.onUserInteraction,
                      validator: (phone) {
                        if (phone!.isEmpty) {
                          return "휴대전화 번호을 입력하세요.";
                        } else if (!regExpPhone.hasMatch(phone)) {
                          return "잘못된 휴대전화 형식 입니다";
                        }
                        return null;
                      },
                      button: InkWell(
                        onTap: () {
                          controller.requestSms();
                          FocusScope.of(context)
                              .requestFocus(controller.codeNode);
                        },
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
                      ),
                    ),
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
                                return "휴대전화 번호을 입력하세요.";
                              }
                              return null;
                            },
                            button: InkWell(
                              onTap: () {
                                controller.signInWithPhone();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(color: subColor)),
                                child: const Text(
                                  "인증확인",
                                  style:
                                      TextStyle(fontSize: 10, color: subColor),
                                ),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 8,
              color: borderColor,
            ),
            const SizedBox(
              height: kMiddleSpace,
            ),
            Obx(
              () => Container(
                padding: const EdgeInsets.only(
                    left: kHorizontalPadding,
                    right: kHorizontalPadding,
                    top: kHorizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "약관 동의",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    CheckboxListTile(
                      checkColor: Colors.black,
                      activeColor: background,
                      contentPadding: EdgeInsets.zero,
                      title: const Text("전체 동의 합니다.",
                          style: TextStyle(fontSize: 14)),
                      value: controller.allAgree.value,
                      onChanged: (value) {
                        controller.agreeCheck("all");
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    Container(
                      width: double.infinity,
                      height: 0.5,
                      color: borderColor,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CheckboxListTile(
                            checkColor: Colors.black,
                            activeColor: background,
                            contentPadding: EdgeInsets.zero,
                            title: const Text("이용 약관에 동의 합니다. (필수)",
                                style: TextStyle(fontSize: 12)),
                            value: controller.useAgree.value,
                            onChanged: (value) {
                              controller.agreeCheck("use");
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                        ),
                        TextButton(onPressed: () {}, child: const Text("내용보기"))
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CheckboxListTile(
                            checkColor: Colors.black,
                            activeColor: background,
                            contentPadding: EdgeInsets.zero,
                            title: const Text("개인정보 수집 및 이용에 동의합니다. (필수)",
                                style: TextStyle(fontSize: 12)),
                            value: controller.infoAgree.value,
                            onChanged: (value) {
                              controller.agreeCheck("info");
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                        ),
                        TextButton(onPressed: () {}, child: const Text("내용보기"))
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CheckboxListTile(
                            checkColor: Colors.black,
                            activeColor: background,
                            contentPadding: EdgeInsets.zero,
                            title: const Text("만 14세 이상입니다. (필수)",
                                style: TextStyle(fontSize: 12)),
                            value: controller.ageAgree.value,
                            onChanged: (value) {
                              controller.agreeCheck("age");
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                        ),
                        TextButton(onPressed: () {}, child: const Text("내용보기"))
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
            Obx(
              () => ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor:
                        controller.activeSignUp ? background : Colors.grey,
                    minimumSize: const Size(double.maxFinite, kButtonHeight),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero)),
                onPressed: () {
                  if (controller.activeSignUp == false) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      margin: EdgeInsets.only(
                          left: kHorizontalPadding,
                          right: kHorizontalPadding,
                          bottom: 80),
                      behavior: SnackBarBehavior.floating,
                      content: Text("약관동의에 동의하세요"),
                      duration: Duration(seconds: 1),
                    ));
                  } else {
                    controller.signUpUserCredential();
                  }
                },
                child: const Text(
                  "투게더 시작하기",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
