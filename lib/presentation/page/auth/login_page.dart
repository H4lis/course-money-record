import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_record/config/app_asset.dart';
import 'package:money_record/config/app_color.dart';
import 'package:money_record/data/source/source_user.dart';
import 'package:money_record/presentation/page/auth/register_page.dart';
import 'package:money_record/presentation/page/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();
  login() async {
    // if (formKey.currentState!.validate()) {
    bool success =
        await SourceUser.login(controllerEmail.text, controllerPassword.text);
    if (success) {
      print("Succesji");
      DInfo.dialogSuccess(context, "Berhasil Login");
      DInfo.closeDialog(context, actionAfterClose: () {
        Get.off(() => HomePage());
      });
    } else {
      DInfo.dialogError(context, "Gagal Login");
      DInfo.closeDialog(context);
    }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bg,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DView.nothing(),
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [
                          Image.asset(AppAsset.logo),
                          DView.spaceHeight(40),
                          TextFormField(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            validator: (value) =>
                                value == '' ? 'Jangan Kosong' : null,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: controllerEmail,
                            decoration: InputDecoration(
                                fillColor: AppColor.primary.withOpacity(0.5),
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none),
                                hintText: 'Email',
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 16)),
                          ),
                          DView.spaceHeight(20),
                          TextFormField(
                            controller: controllerPassword,
                            validator: (value) =>
                                value == '' ? 'Jangan Kosong' : '',
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            obscureText: true,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                                fillColor: AppColor.primary.withOpacity(0.5),
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none),
                                hintText: 'Password',
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 16)),
                          ),
                          DView.spaceHeight(40),
                          Material(
                            color: AppColor.primary,
                            borderRadius: BorderRadius.circular(30),
                            child: InkWell(
                              onTap: () {
                                login();
                              },
                              borderRadius: BorderRadius.circular(30),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 40,
                                  vertical: 16,
                                ),
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Belum Punya Akun? ",
                          style: TextStyle(fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => RegisterPage());
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(
                              color: AppColor.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
