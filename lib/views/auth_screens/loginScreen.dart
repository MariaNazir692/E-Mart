import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/views/auth_screens/signUpScreen.dart';
import 'package:e_mart/views/home_Screen/home.dart';
import 'package:e_mart/views/home_Screen/home_screen.dart';
import 'package:get/get.dart';

import '../../common_widgets/applogo_widgets.dart';
import '../../common_widgets/bg_widget.dart';
import '../../common_widgets/customBtn.dart';
import '../../common_widgets/custom_formFields.dart';
import '../../consts/lists.dart';
import '../../controller/auth_controller.dart';

class logInScreen extends StatefulWidget {
  const logInScreen({Key? key}) : super(key: key);

  @override
  State<logInScreen> createState() => _logInScreenState();
}

class _logInScreenState extends State<logInScreen> {


  var controller = Get.put(AuthController());

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
            "Log In to $appname"
                .text
                .white
                .size(20)
                .fontFamily(semibold)
                .make(),
            10.heightBox,
            Obx(
              ()=> Column(
                children: [
                  10.heightBox,
                  CustomTextFields(title: email, hint: emailHints,  isPass: false,controller: controller.emailController),
                  CustomTextFields(title: password, hint: passwordHint,  isPass: true, controller: controller.passController),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: forgetPass.text.make(),
                    ),
                  ),
                  5.heightBox,
                 controller.isloading.value ? CircularProgressIndicator(
                   valueColor: AlwaysStoppedAnimation(redColor),
                 ): CustomBtn(
                          title: logIn,
                          color: redColor,
                          onPress: () async{
                            controller.isloading(true);
                            await controller.loginMethod(context: context).then((value){
                              if(value!=null){
                                Get.offAll(()=>Home());
                              }else{
                                controller.isloading(false);
                                VxToast.show(context, msg: "SomethingWent Wrong");
                              }
                            });
                          },
                          textColor: whiteColor)
                      .box
                      .width(context.screenWidth - 50)
                      .make(),
                  10.heightBox,
                  creatNewAccount.text.color(fontGrey).make(),
                  10.heightBox,
                  CustomBtn(
                          title: signUp,
                          color: lightGolden,
                          onPress: () {
                            Get.to(()=>SignUpScreen());
                          },
                          textColor: redColor)
                      .box
                      .width(context.screenWidth - 50)
                      .make(),
                  10.heightBox,
                  logInWith.text.color(fontGrey).make(),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        3, (index) => Padding(
                      padding: EdgeInsets.all(10),
                      child: CircleAvatar(
                        backgroundColor: lightGrey,
                        radius: 25,
                        child: Image.asset(socialIconList[index], width: 30,),
                      ),
                    )),
                  )
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(EdgeInsets.all(16))
                  .width(context.screenWidth - 70).shadowSm
                  .make(),
            ),
          ],
        ),
      ),
    ));
  }
}
