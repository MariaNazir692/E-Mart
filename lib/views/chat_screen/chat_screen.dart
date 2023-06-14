import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart/common_widgets/loadingIndicator.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/controller/chatsController.dart';
import 'package:get/get.dart';

import '../../services/firestore_services.dart';
import 'component/sender_bubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller=Get.put(ChatsController());

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        title: "${controller.friendName}".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Obx(()=>
                controller.isLoading.value?Center(
                  child: "Send a Message....".text.color(darkFontGrey).fontFamily(semibold).make(),
                ):Expanded(
                child: StreamBuilder(
                  stream: FirestoreServices.getChatMsgs(controller.chatDocId.toString()),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                    if(!snapshot.hasData){
                      return LoadingIndicator();
                    }else if(snapshot.data!.docs.isEmpty){
                      return Center(
                        child: "Send a Message....".text.color(darkFontGrey).fontFamily(semibold).make(),
                      );
                    }else{
                      return ListView(
                        children:snapshot.data!.docs.mapIndexed((currentValue, index){
                          var data=snapshot.data!.docs[index];
                          return Align(
                            alignment: data['uid']==currentUser!.uid?Alignment.centerRight:Alignment.centerLeft,
                              child: SenderBubble(data));
                        }).toList(),
                      );
                    }

                  },
                ),
              ),
            ),
            10.heightBox,
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                      controller: controller.msgController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: textfieldGrey)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: textfieldGrey)),
                      hintText: "Type a message...."),
                )),
                IconButton(
                    onPressed: () {
                      controller.sendMsg(controller.msgController.text);
                      controller.msgController.clear();
                    },
                    icon: Icon(
                      Icons.send,
                      color: redColor,
                    ))
              ],
            )
                .box
                .height(80)
                .padding(EdgeInsets.all(12))
                .margin(EdgeInsets.only(bottom: 10))
                .make()
          ],
        ),
      ),
    );
  }
}
