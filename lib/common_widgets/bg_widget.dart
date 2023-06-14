import 'package:e_mart/consts/consts.dart';

Widget BgWidget(Widget? child){
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(image: AssetImage(imgBackground,), fit: BoxFit.fill),
    ),
    child: child,

  );
}