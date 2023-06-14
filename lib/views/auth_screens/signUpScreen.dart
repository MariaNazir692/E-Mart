import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/controller/auth_controller.dart';
import 'package:get/get.dart';
import '../../common_widgets/applogo_widgets.dart';
import '../../common_widgets/bg_widget.dart';
import '../../common_widgets/customBtn.dart';
import '../../common_widgets/custom_formFields.dart';
import '../home_Screen/home.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isCheck = false;
  var controller = Get.put(AuthController());

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var confirmpassController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    confirmpassController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BgWidget(Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            //this making a distance from top of screen it will take 7% of screen from top this make screen
            //responsive
            (context.screenHeight * 0.07).heightBox,
            appLogoWidget(),
            10.heightBox,
            "Join the $appname".text.white.size(20).fontFamily(semibold).make(),
            10.heightBox,
            Obx(()=> Column(
                children: [
                  10.heightBox,
                  CustomTextFields(
                      title: Name, hint: nameHint, controller: nameController, isPass: false),
                  CustomTextFields(
                      title: email,
                      hint: emailHints,
                      controller: emailController,
                    isPass: false
                  ),
                  CustomTextFields(
                      title: password,
                      hint: passwordHint,
                      controller: passController,
                      isPass: true

                  ),
                  CustomTextFields(
                      title: confirmPass,
                      hint: passwordHint,
                      controller: confirmpassController,
                      isPass: true
                  ),
                  5.heightBox,
                  Row(
                    children: [
                      Checkbox(
                          checkColor: Colors.white,
                          activeColor: Colors.red,
                          value: isCheck,
                          onChanged: (newValue) {
                            setState(() {
                              isCheck = newValue!;
                            });
                          }),
                      5.widthBox,
                      Expanded(
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "I agree to the ",
                              style: TextStyle(
                                  fontFamily: regular, color: fontGrey)),
                          TextSpan(
                              text: terms,
                              style: TextStyle(
                                  fontFamily: regular, color: redColor)),
                          TextSpan(
                              text: " & ",
                              style: TextStyle(
                                  fontFamily: regular, color: fontGrey)),
                          TextSpan(
                              text: policy,
                              style: TextStyle(
                                  fontFamily: regular, color: redColor)),
                        ])),
                      )
                    ],
                  ),
                 controller.isloading.value?const CircularProgressIndicator(
                   valueColor: AlwaysStoppedAnimation(redColor),
                 ): CustomBtn(
                          title: signUp,
                          color: isCheck ? redColor : lightGrey,
                          onPress: () async {
                            if (isCheck != false) {
                              try {
                                controller.isloading(true);
                                await controller
                                    .signUpMethod(
                                        context: context,
                                        email: emailController.text,
                                        password: passController.text)
                                    .then((value) {
                                  return controller.storeUserDate(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passController.text);
                                }).then((value) {
                                  VxToast.show(context, msg: loggedIn);
                                  return Get.offAll(Home());
                                });
                              } catch (e) {
                                controller.isloading(false);
                                auth.signOut();
                                VxToast.show(context, msg: e.toString());
                              }
                            }
                          },
                          textColor: whiteColor)
                      .box
                      .width(context.screenWidth - 50)
                      .make(),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        alreadyaccount,
                        style: TextStyle(
                            color: fontGrey, fontFamily: semibold, fontSize: 12),
                      ),
                      InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Text(
                            logIn,
                            style: TextStyle(
                                color: redColor,
                                fontFamily: semibold,
                                fontSize: 12),
                          )),
                    ],
                  ),
                  10.heightBox,
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .shadowSm
                  .make(),
            ),
          ],
        ),
      ),
    ));
  }
}
