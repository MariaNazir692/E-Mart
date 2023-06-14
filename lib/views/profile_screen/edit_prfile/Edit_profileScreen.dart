import 'dart:io';
import 'package:e_mart/common_widgets/customBtn.dart';
import 'package:e_mart/common_widgets/custom_formFields.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/controller/profile_controller.dart';
import 'package:get/get.dart';
import '../../../common_widgets/bg_widget.dart';
import '../profile_screen.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;

  const EditProfileScreen({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return BgWidget(SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: Obx(
          () => SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                data['photoUrl'] == ' ' && controller.profileImagePath.isEmpty
                    ? Image.asset(
                        imgP1,
                        fit: BoxFit.cover,
                        width: 70,
                      ).box.roundedFull.clip(Clip.antiAlias).make()
                    : data['photoUrl'] != '' &&
                            controller.profileImagePath.isEmpty
                        ? Image.network(
                            data['photoUrl'],
                            fit: BoxFit.cover,
                            width: 70,
                          ).box.roundedFull.clip(Clip.antiAlias).make()
                        : Image.file(
                            File(controller.profileImagePath.value),
                            fit: BoxFit.cover,
                            width: 70,
                          ).box.roundedFull.clip(Clip.antiAlias).make(),
                10.heightBox,
                CustomBtn(
                    title: "Change",
                    textColor: whiteColor,
                    onPress: () {
                      controller.changeImage(context);
                    },
                    color: redColor),
                10.heightBox,
                CustomTextFields(
                    hint: nameHint,
                    title: Name,
                    isPass: false,
                    controller: controller.nameController),
                10.heightBox,
                CustomTextFields(
                    hint: passwordHint,
                    title: oldPass,
                    isPass: true,
                    controller: controller.oldpassController),
                10.heightBox,
                CustomTextFields(
                    hint: passwordHint,
                    title: newPass,
                    isPass: true,
                    controller: controller.newpassController),
                10.heightBox,
                controller.isloading.value
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      )
                    : SizedBox(
                        width: context.screenWidth * 60,
                        child: CustomBtn(
                            title: "Save",
                            textColor: whiteColor,
                            onPress: () async {
                              controller.isloading(true);
                              if (controller.profileImagePath.value.isNotEmpty) {
                                await controller.UploadProfileImage();
                              } else {
                                controller.profileImageDownloadLink =
                                    data['photoUrl'];
                              }
                              if (data['password'] ==
                                  controller.oldpassController.text) {
                                await controller.changeAuthPassword(
                                    email: data['email'], password: controller.oldpassController.text,
                                newPassword: controller.newpassController.text);

                                await controller.updateProfile(
                                    imageUrl: controller.profileImageDownloadLink,
                                    name: controller.nameController.text,
                                    password: controller.newpassController.text);
                                VxToast.show(context, msg:"Profile Updated");
                                Get.to(() => const ProfileScreen());
                              } else {
                                VxToast.show(context,
                                    msg: "Something went wrong");
                              }
                            },
                            color: redColor)
                )
              ],
            )
                .box
                .rounded
                .shadowSm
                .white
                .padding(EdgeInsets.all(16))
                .margin(EdgeInsets.only(top: 50, left: 10, right: 10))
                .make(),
          ),
        ),
      ),
    ));
  }
}
