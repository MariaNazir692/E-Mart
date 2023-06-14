import 'package:e_mart/consts/colors.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/views/home_Screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common_widgets/applogo_widgets.dart';
import '../auth_screens/loginScreen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
                child: Image.asset(icSplashBg, width: 300,)),
            20.heightBox,
            appLogoWidget(),
            10.heightBox,
            appname.text.fontFamily(bold).size(22).white.make(),
            5.heightBox,
            appversion.text.white.make(),
            Spacer(),
            credits.text.white.fontFamily(semibold).make(),
            30.heightBox

          ],
        )
      ),

    );
  }

  ChangeScreen(){
    Future.delayed(Duration(seconds: 3), (){
      auth.authStateChanges().listen((User? user) {
        if(user==null){
          Get.to(()=>logInScreen());
        }else{
          Get.to(()=>Home());
        }
      });
    });
  }
  @override
  void initState() {
    ChangeScreen();
    // TODO: implement initState
    super.initState();
  }
}
