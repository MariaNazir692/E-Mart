import 'package:e_mart/consts/consts.dart';

Widget CardDetail({String? count, String? title, width}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.fontFamily(bold).color(darkFontGrey).make(),
      5.heightBox,
      title!.text.color(darkFontGrey).make(),
    ],
  )
      .box
      .padding(EdgeInsets.all(4))
      .white
      .rounded
      .width(width)
      .height(60)
      .make();

}