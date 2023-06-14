import 'package:e_mart/consts/consts.dart';

Widget OrderStatus({icon, color, title, showDone}){
  return ListTile(
    leading: Icon(icon, color: color,).box.border(color: color).padding(EdgeInsets.all(5)).make(),
    trailing: SizedBox(
       width: 150,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          "$title".text.color(darkFontGrey).make(),
          showDone?Icon(Icons.done, color: redColor,):Container()
        ],
      ),
    ),
  );
}