import 'package:e_mart/consts/consts.dart';

Widget HomeBtns({height, width, icon, String? title, onPress}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(icon, width: 26,),
      5.heightBox,
      title!.text.color(darkFontGrey).fontFamily(regular).make()
    ],
  ).box.rounded.white.size(width, height).make();
}