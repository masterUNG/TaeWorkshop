import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taewhorkshop/models/user_model.dart';
import 'package:taewhorkshop/states/create_new_account.dart';
import 'package:taewhorkshop/utility/app_controller.dart';
import 'package:taewhorkshop/utility/app_dialog.dart';
import 'package:taewhorkshop/utility/app_service.dart';
import 'package:taewhorkshop/widgets/widget_button.dart';
import 'package:taewhorkshop/widgets/widget_form.dart';
import 'package:taewhorkshop/widgets/widget_head.dart';
import 'package:taewhorkshop/widgets/widget_text_button.dart';

class Authen extends StatefulWidget {
  const Authen({super.key});

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  String? email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX(
          init: AppController(),
          builder: (AppController appController) {
            print('userModels ---> ${appController.userModels.length}');
            return ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 100),
                      width: 250,
                      child: const WidgetHead(),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WidgetForm(
                      hint: 'Email :',
                      changeFunc: (p0) {
                        email = p0.trim();
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WidgetForm(
                      hint: 'Password :',
                      changeFunc: (p0) {
                        password = p0.trim();
                      },
                      obsecu: true,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      width: 250,
                      child: WidgetButton(
                        label: 'Login',
                        pressFunc: () async {
                          if ((email?.isEmpty ?? true) ||
                              (password?.isEmpty ?? true)) {
                            AppDialog(context: context).normalDialot(
                                title: 'Have Space ?',
                                detail: 'Please Fill Every Blank');
                          } else {
                            print('email = $email, password = $password');
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: email!, password: password!)
                                .then((value) async {
                              String uidLogin = value.user!.uid;
                              print('uidLogin = $uidLogin');

                              UserModle? userModle = await AppService()
                                  .findUserModel(uidLogin: uidLogin);

                              if (userModle != null) {
                                print('typeUser = ${userModle.typeUser}');

                                appController.userModels.add(userModle);

                                Get.offAllNamed('/${userModle.typeUser}');
                              }
                            }).catchError((onError) {
                              AppDialog(context: context).normalDialot(
                                  title: onError.code, detail: onError.message);
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                WidgetTextButton(
                  label: 'Create New Account',
                  pressFunc: () {
                    Get.to(const CreateNewAccount());
                  },
                ),
              ],
            );
          }),
    );
  }
}
