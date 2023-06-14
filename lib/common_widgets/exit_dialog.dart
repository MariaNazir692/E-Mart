import 'package:e_mart/common_widgets/customBtn.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:flutter/services.dart';

Widget ExitDialog(context){
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).color(darkFontGrey).size(18).make(),
        const Divider(),
        10.heightBox,
        "Are you sure to want to exit".text.color(darkFontGrey).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomBtn(
              color: redColor,
              title: "Yes",
              textColor: whiteColor,
              onPress: (){
                //to exit from app
                SystemNavigator.pop();
              },
            ),
            CustomBtn(
              color: redColor,
              title: "No",
              textColor: whiteColor,
              onPress: (){
                //to exit from dialog
                Navigator.pop(context);
              },
            ),
          ],

        )
        
      ],
    ).box.roundedSM.padding(EdgeInsets.all(12)).color(lightGrey).make(),
  );
}