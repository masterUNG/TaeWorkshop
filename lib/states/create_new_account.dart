import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taewhorkshop/models/user_model.dart';
import 'package:taewhorkshop/utility/app_constant.dart';
import 'package:taewhorkshop/utility/app_controller.dart';
import 'package:taewhorkshop/utility/app_dialog.dart';
import 'package:taewhorkshop/utility/app_service.dart';
import 'package:taewhorkshop/widgets/widget_button.dart';
import 'package:taewhorkshop/widgets/widget_form.dart';
import 'package:taewhorkshop/widgets/widget_map.dart';
import 'package:taewhorkshop/widgets/widget_text.dart';

class CreateNewAccount extends StatefulWidget {
  const CreateNewAccount({super.key});

  @override
  State<CreateNewAccount> createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  String? name, email, password;

  @override
  void initState() {
    super.initState();
    AppService().findPosition(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: WidgetText(
          data: 'Create New Account',
          textStyle: AppConstant().h2Style(),
        ),
      ),
      body: GetX(
          init: AppController(),
          builder: (AppController appController) {
            print('position --> ${appController.positions.length}');
            return ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WidgetForm(
                      hint: 'Display Name :',
                      changeFunc: (p0) {
                        name = p0.trim();
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      width: 250,
                      child: DropdownButton(
                        isExpanded: true,
                        hint: const WidgetText(data: 'Type User :'),
                        value: appController.typeUserChooses.last,
                        items: AppConstant.typeUsers
                            .map(
                              (e) => DropdownMenuItem(
                                child: WidgetText(data: e),
                                value: e,
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          appController.typeUserChooses.add(value);
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(border: Border.all()),
                      margin: const EdgeInsets.only(top: 16),
                      width: 250,
                      height: 200,
                      child: appController.positions.isEmpty
                          ? const SizedBox()
                          : WidgetMap(),
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
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 250,
                      margin: const EdgeInsets.only(top: 16),
                      child: WidgetButton(
                        label: 'Create New Account',
                        pressFunc: () async {
                          if ((name?.isEmpty ?? true) ||
                              (email?.isEmpty ?? true) ||
                              (password?.isEmpty ?? true)) {
                            AppDialog(context: context).normalDialot(
                                title: 'Have Space ?',
                                detail: 'Please Fill Every Blank');
                          } else if (appController.typeUserChooses.last ==
                              null) {
                            AppDialog(context: context).normalDialot(
                                title: 'Non Type User ?',
                                detail: 'Plese Choose Type User');
                          } else {
                            await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: email!, password: password!)
                                .then((value) async {
                              String uid = value.user!.uid;
                              UserModle modle = UserModle(
                                  name: name!,
                                  typeUser: appController.typeUserChooses.last!,
                                  email: email!,
                                  password: password!,
                                  geoPoint: GeoPoint(
                                      appController.positions.last.latitude,
                                      appController.positions.last.longitude));

                              await FirebaseFirestore.instance
                                  .collection('user')
                                  .doc(uid)
                                  .set(modle.toMap())
                                  .then((value) => Get.back());
                            }).catchError((onError) {
                              AppDialog(context: context).normalDialot(
                                  title: onError.code, detail: onError.message);
                            });
                          }
                        },
                      ),
                    ),
                  ],
                )
              ],
            );
          }),
    );
  }
}
