import 'package:e_mart/consts/consts.dart';

Widget LoadingIndicator(){
  return CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(redColor)
  );
}