import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart/common_widgets/bg_widget.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/controller/productController.dart';
import 'package:e_mart/services/firestore_services.dart';
import 'package:e_mart/views/category/item_details.dart';
import 'package:get/get.dart';

import '../../common_widgets/loadingIndicator.dart';
import '../../consts/lists.dart';

class CategoryDetails extends StatefulWidget {
  final String? title;

  const CategoryDetails({Key? key, required this.title}) : super(key: key);

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  var controller = Get.put(ProductController());

  dynamic productMethod;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switchCategory(widget.title);
  }

  switchCategory(title) {
    if (controller.subcat.contains(title)) {
      productMethod = FirestoreServices.getSubCategoryProducts(title);
    } else {
      productMethod = FirestoreServices.getProduct(title);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BgWidget(Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: widget.title!.text.fontFamily(bold).white.make(),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                  controller.subcat.length,
                  (index) => "${controller.subcat[index]}"
                          .text
                          .color(darkFontGrey)
                          .fontFamily(semibold)
                          .makeCentered()
                          .box
                          .white
                          .rounded
                          .size(150, 60)
                          .margin(const EdgeInsets.symmetric(horizontal: 4))
                          .make()
                          .onTap(() {
                        switchCategory("${controller.subcat[index]}");
                        setState(() {});
                      })),
            ),
          ),
          20.heightBox,
          StreamBuilder(
            stream: productMethod,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Expanded(
                    child: Center(
                        child: LoadingIndicator()
                    )
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return const Expanded(
                  child: Center(
                    child: Text(
                      "No Products Found.....",
                      style: TextStyle(
                          color: darkFontGrey, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              } else {
                var data = snapshot.data!.docs;
                return Expanded(
                    child: GridView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 250,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Image.network(
                                data[index]['p_images'][0],
                                width: 190,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                              "${data[index]['p_name']}"
                                  .text
                                  .color(darkFontGrey)
                                  .fontFamily(regular)
                                  .make(),
                              10.heightBox,
                              "${data[index]['p_price']}"
                                  .numCurrency
                                  .text
                                  .color(redColor)
                                  .fontFamily(bold)
                                  .make(),
                            ],
                          )
                              .box
                              .white
                              .rounded
                              .shadowSm
                              .margin(const EdgeInsets.symmetric(horizontal: 4))
                              .padding(const EdgeInsets.all(12))
                              .make()
                              .onTap(() {
                            controller.checkIfFav(data[index]);
                            Get.to(ItemDetail(
                              title: "${data[index]['p_name']}",
                              data: data[index],
                            ));
                          });
                        }));
              }
            },
          ),
        ],
      ),
    ));
  }
}
