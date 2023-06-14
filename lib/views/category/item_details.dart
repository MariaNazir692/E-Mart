import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/controller/productController.dart';
import 'package:e_mart/views/cart_screen/cart_screen.dart';
import 'package:e_mart/views/chat_screen/chat_screen.dart';
import 'package:get/get.dart';

import '../../common_widgets/customBtn.dart';
import '../../consts/lists.dart';

class ItemDetail extends StatelessWidget {
  final String? title;
  final dynamic data;

  const ItemDetail({Key? key, required this.title, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return WillPopScope(
      onWillPop: ()async{
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              controller.resetValues();
              Get.back();
            },
            icon: Icon(Icons.arrow_back),
          ),
          elevation: 0,
          title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
            Obx(()=> IconButton(
                  onPressed: () {
                    if(controller.isFav.value){
                      controller.removeFromWishList(data.id,context);
                      controller.isFav(false);
                    }else{
                      controller.addToWishList(data.id,context);
                      controller.isFav(true);
                    }
                  }, icon: Icon(Icons.favorite_outlined,color: controller.isFav.value?redColor:darkFontGrey,)),
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(12),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VxSwiper.builder(
                      autoPlay: true,
                      height: 250,
                      itemCount: data['p_images'].length,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1.0,
                      itemBuilder: (context, index) {
                        return Image.network(
                          data['p_images'][index],
                          width: double.infinity,
                          fit: BoxFit.fill,
                        );
                      },
                    ),
                    10.heightBox,
                    title!.text
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .size(20)
                        .make(),
                    10.heightBox,
                    VxRating(
                      value: double.parse(data['p_rating']),
                      onRatingUpdate: (value) {},
                      normalColor: textfieldGrey,
                      selectionColor: golden,
                      count: 5,
                      maxRating: 5,
                      stepInt: false,
                    ),
                    "${data['p_price']}"
                        .numCurrency
                        .text
                        .color(redColor)
                        .fontFamily(bold)
                        .size(18)
                        .make(),
                    10.heightBox,
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            "Seller".text.white.fontFamily(semibold).make(),
                            5.heightBox,
                            "${data['p_seller']}"
                                .text
                                .color(darkFontGrey)
                                .fontFamily(semibold)
                                .make(),
                          ],
                        )),
                        const CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.message_rounded,
                            color: darkFontGrey,
                          ),
                        ).onTap(() {
                          Get.to(()=>ChatScreen(),arguments: [data['p_seller'], data['vendor_id']]);
                        })
                      ],
                    )
                        .box
                        .padding(const EdgeInsets.symmetric(horizontal: 10))
                        .height(60)
                        .color(textfieldGrey)
                        .make(),
                    20.heightBox,
                    Obx(
                      () => Column(
                        children: [
                          Obx(
                            () => Row(children: [
                              SizedBox(
                                  width: 100,
                                  child: "Quantity"
                                      .text
                                      .color(textfieldGrey)
                                      .make()),
                              IconButton(
                                  onPressed: () {
                                    controller.decreaseQuantity();
                                    controller.calculateTotalPrice(
                                        int.parse(data['p_price']));
                                  },
                                  icon: Icon(Icons.remove)),
                              controller.quantity.value.text
                                  .size(16)
                                  .color(darkFontGrey)
                                  .fontFamily(bold)
                                  .make(),
                              IconButton(
                                  onPressed: () {
                                    controller.increaseQuantity(
                                        int.parse(data['p_quantity']));
                                    controller.calculateTotalPrice(
                                        int.parse(data['p_price']));
                                  },
                                  icon: Icon(Icons.add)),
                              10.widthBox,
                              "(${data['p_quantity']} availabe)"
                                  .text
                                  .color(textfieldGrey)
                                  .make()
                            ]),
                          ),
                          20.heightBox,
                          Row(
                            children: [
                              SizedBox(
                                  width: 100,
                                  child:
                                      "Total".text.color(textfieldGrey).make()),
                              "${controller.totalPrice.value}"
                                  .numCurrency
                                  .text
                                  .color(redColor)
                                  .fontFamily(bold)
                                  .size(16)
                                  .make()
                            ],
                          )
                              .box
                              .padding(EdgeInsets.all(12))
                              .color(lightGolden)
                              .make(),
                        ],
                      ).box.white.shadowSm.make(),
                    ),
                    10.heightBox,
                    "Description"
                        .text
                        .fontFamily(bold)
                        .color(darkFontGrey)
                        .make(),
                    10.heightBox,
                    "${data['p_desc']}"
                        .text
                        .fontFamily(regular)
                        .color(darkFontGrey)
                        .make(),
                    10.heightBox,
                    ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(
                          itemDetailbtnList.length,
                          (index) => ListTile(
                                title: "${itemDetailbtnList[index]}"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                trailing: Icon(Icons.arrow_forward),
                              )),
                    ),
                    20.heightBox,
                    productyouLike.text
                        .color(darkFontGrey)
                        .fontFamily(bold)
                        .size(22)
                        .make(),
                    20.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            6,
                            (index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      imgP1,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                    10.heightBox,
                                    "Laptop 4GB/256GB"
                                        .text
                                        .color(darkFontGrey)
                                        .fontFamily(regular)
                                        .make(),
                                    10.heightBox,
                                    "\$600"
                                        .text
                                        .color(redColor)
                                        .fontFamily(bold)
                                        .make(),
                                  ],
                                )
                                    .box
                                    .white
                                    .rounded
                                    .margin(
                                        const EdgeInsets.symmetric(horizontal: 4))
                                    .padding(const EdgeInsets.all(8))
                                    .make()),
                      ),
                    )
                  ],
                ),
              ),
            )),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: CustomBtn(
                  title: "Add to cart",
                  color: redColor,
                  onPress: () {
                    if (controller.quantity.value == 0) {
                      VxToast.show(context,
                          msg: "Choose at least one product to add to cart");
                    } else {
                      controller.addToCart(
                        color: data['p_colors'][controller.colorIndex.value],
                        context: context,
                        img: data['p_images'][0],
                        qty: controller.quantity.value,
                        sellername: data['p_seller'],
                        tprice: controller.totalPrice.value,
                        title: data['p_name'],
                        vendorId: data['vendor_id']
                      );
                      VxToast.show(context, msg: "Added to Cart");
                      Get.to(()=>CartScreen());
                    }
                  },
                  textColor: whiteColor),
            )
          ],
        ),
      ),
    );
  }
}
