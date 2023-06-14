import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart/common_widgets/customBtn.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/services/firestore_services.dart';
import 'package:e_mart/views/shippingScreens/shippingDetails.dart';
import 'package:get/get.dart';

import '../../common_widgets/loadingIndicator.dart';
import '../../controller/cart_Controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller=Get.put(CartController());

    return Scaffold(
      backgroundColor: whiteColor,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: "Shopping Cart"
              .text
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make(),
        ),
        body: StreamBuilder(
          stream: FirestoreServices.getCartData(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: LoadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  "Cart is Empty",
                  style: TextStyle(
                      color: darkFontGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
              );
            } else {
              var data = snapshot.data!.docs;
              controller.calculate(data);
              controller.productSnapshot=data;

              return Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    Expanded(
                        child: Container(

                          child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, int index) {
                                return ListTile(
                                    leading: Image.network(
                                        "${data[index]['img']}",
                                      width: 120,
                                      fit: BoxFit.cover,

                                    ),
                                    title: "${data[index]['title']}".text
                                        .fontFamily(semibold).make(),
                                    subtitle: "${data[index]['tprice']}".text
                                        .fontFamily(regular)
                                        .color(redColor)
                                        .make(),
                                  trailing: Icon(Icons.delete, color: redColor,).onTap(() { 
                                    FirestoreServices.deleteCartItem(data[index].id);
                                  }),
                                );
                              }
                          ),
                        )
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Total Price"
                            .text
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                        Obx(()=> "${controller.totalPrice.value}"
                              .numCurrency
                              .text
                              .fontFamily(semibold)
                              .color(redColor)
                              .make(),
                        ),
                      ],
                    )
                        .box
                        .roundedSM
                        .width(context.screenWidth - 60)
                        .color(lightGolden)
                        .padding(EdgeInsets.all(12))
                        .make(),
                    10.heightBox,
                    CustomBtn(
                        color: redColor,
                        title: "Proceed to Shipping",
                        textColor: whiteColor,
                        onPress: () {
                          Get.to(()=>ShippingDetails());
                        })
                  ],
                ),
              );
            }
          },
        ));
  }
}
