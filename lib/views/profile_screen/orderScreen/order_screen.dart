import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart/common_widgets/loadingIndicator.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/services/firestore_services.dart';
import 'package:e_mart/views/profile_screen/orderScreen/orderDetail.dart';
import 'package:get/get.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        title: "My Orders".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllOrders(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: LoadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "No Orders yet....".text.color(darkFontGrey).makeCentered();
          } else {
            var data = snapshot.data!.docs;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, index) {
                  return ListTile(
                    onTap: (){
                      Get.to(()=>OrdersDetail(data:data[index]));
                    },
                    leading: "${index+1}".text.color(darkFontGrey).fontFamily(bold).xl.make(),
                    title: data[index]['order_code']
                        .toString()
                        .text
                        .color(redColor)
                        .fontFamily(semibold)
                        .make(),
                    subtitle: data[index]['total_amount']
                        .toString().numCurrency
                        .text
                        .fontFamily(bold)
                        .make(),
                    trailing: IconButton(
                      onPressed: (){
                        Get.to(()=>OrdersDetail(data:data[index]));
                      },
                      icon: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
