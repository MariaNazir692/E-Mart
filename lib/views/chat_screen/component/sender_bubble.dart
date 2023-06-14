import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:intl/intl.dart' as intl;

Widget SenderBubble(DocumentSnapshot data){

  var t= data['created_on']== null? DateTime.now():data['created_on'].toDate();
  var time=intl.DateFormat("h:mma").format(t);

  return  Directionality(
    textDirection: data['uid']==currentUser!.uid? TextDirection.rtl:TextDirection.ltr,
    child: Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(8),
      decoration:  BoxDecoration(
        color: data['uid']==currentUser!.uid?Colors.green: darkFontGrey ,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "${data['msg']}".text.white.size(15).make(),
          10.heightBox,
          time.text.color(whiteColor.withOpacity(0.5)).make(),
        ],
      ),
    ),
  );
}