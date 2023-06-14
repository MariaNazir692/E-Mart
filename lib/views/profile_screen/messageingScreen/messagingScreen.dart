import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart/common_widgets/loadingIndicator.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/services/firestore_services.dart';
import 'package:e_mart/views/chat_screen/chat_screen.dart';
import 'package:get/get.dart';



class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        title: "My Messages".text.color(darkFontGrey).fontFamily(semibold).make(),),
      body: StreamBuilder(
        stream:FirestoreServices.getAllMessages() ,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(child: LoadingIndicator(),);
          }else if(snapshot.data!.docs.isEmpty){
            return "No Messages yet....".text.color(darkFontGrey).makeCentered();
          }else{
            var data=snapshot.data!.docs;
            return Column(
              children: [
                Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                        itemBuilder: (context, index){
                        return Card(
                          child: ListTile(
                            onTap: (){
                              Get.to(()=>ChatScreen(),arguments: [
                                data[index]['friend_name'],data[index]['toId']
                              ]);
                            },
                            leading: CircleAvatar(
                              backgroundColor: redColor,
                              child: Icon(Icons.person,color: whiteColor,),
                            ),
                            title: "${data[index]['friend_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                            subtitle: "${data[index]['last_msg']}".text.make(),
                          ),
                        );
                        }

                    )
                )
              ],
            );
          }

        },
      ),
    );
  }
}