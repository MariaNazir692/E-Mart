import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart/common_widgets/HomeBtns.dart';
import 'package:e_mart/common_widgets/loadingIndicator.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/controller/home_controller.dart';
import 'package:e_mart/services/firestore_services.dart';
import 'package:e_mart/views/category/item_details.dart';
import 'package:e_mart/views/search_screen/searchScreen.dart';
import 'package:get/get.dart';

import '../../consts/lists.dart';
import 'components/featuredBtn.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller=Get.find<HomeController>();
    return Container(
      width: context.screenWidth,
      height: context.screenHeight,
      color: lightGrey,
      padding: const EdgeInsets.all(12),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 60,
              color: lightGrey,
              child: TextFormField(
                controller: controller.searchController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.search).onTap(() {
                      if(controller.searchController.text.isNotEmptyAndNotNull){
                        Get.to(()=>SearchScreen(title: controller.searchController.text,));
                      }
                    }),
                    filled: true,
                    fillColor: whiteColor,
                    hintText: searchanything,
                    hintStyle: TextStyle(color: textfieldGrey)),
              ),
            ),
            10.heightBox,
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        height: 170,
                        enlargeCenterPage: true,
                        itemCount: brandList.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            brandList[index],
                            fit: BoxFit.fill,
                          )
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(EdgeInsets.symmetric(horizontal: 8))
                              .make();
                        }),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          2,
                          (index) => HomeBtns(
                              title: index == 0 ? todaysdeal : flashsale,
                              icon: index == 0 ? icTodaysDeal : icFlashDeal,
                              width: context.screenWidth / 2.5,
                              height: context.screenHeight * 0.10)),
                    ),
                    10.heightBox,

                    //second swiper
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        height: 170,
                        enlargeCenterPage: true,
                        itemCount: SecondbrandList.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            SecondbrandList[index],
                            fit: BoxFit.fill,
                          )
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(const EdgeInsets.symmetric(horizontal: 8))
                              .make();
                        }),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          3,
                          (index) => HomeBtns(
                              width: context.screenWidth / 3.5,
                              height: context.screenHeight * 0.10,
                              icon: index == 0
                                  ? icTopCategories
                                  : index == 1
                                      ? icBrands
                                      : icTopSeller,
                              title: index == 0
                                  ? topCategries
                                  : index == 1
                                      ? topBrand
                                      : topSellers)),
                    ),
                    20.heightBox,

                    //featured category
                    Align(
                      alignment: Alignment.centerLeft,
                      child: fearturedCategories.text
                          .color(darkFontGrey)
                          .size(18)
                          .make(),
                    ),
                    20.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            3,
                            (index) => Column(
                                  children: [
                                    FeaturedButton(
                                        icon: featuredImage1[index],
                                        title: featuredTitles1[index]),
                                    10.heightBox,
                                    FeaturedButton(
                                        icon: featuredImage2[index],
                                        title: featuredTitles2[index]),
                                  ],
                                )).toList(),
                      ),
                    ),
                    20.heightBox,
                    //featured products
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: redColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          featuredProduct.text.white
                              .fontFamily(semibold)
                              .size(22)
                              .make(),
                          10.heightBox,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: StreamBuilder(
                              stream: FirestoreServices.getFeaturedProducts(),
                              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                                if(!snapshot.hasData){
                                  return Center(child: LoadingIndicator(),);
                                }else if(snapshot.data!.docs.isEmpty){
                                  return "Featured Products are not added yet..".text.white.makeCentered();
                                }else{
                                  var featuredData=snapshot.data!.docs;
                                  return Row(
                                    children: List.generate(
                                        featuredData.length,
                                            (index) => Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Image.network(
                                              featuredData[index]['p_images'][0],
                                              width: 130,
                                              height: 130,
                                              fit: BoxFit.cover,
                                            ),
                                            10.heightBox,
                                            "${featuredData[index]['p_name']}"
                                                .text
                                                .color(darkFontGrey)
                                                .fontFamily(regular)
                                                .make(),
                                            10.heightBox,
                                            "${featuredData[index]['p_price']}"
                                                .text
                                                .color(redColor)
                                                .fontFamily(bold)
                                                .make(),
                                          ],
                                        )
                                            .box
                                            .white
                                            .rounded
                                            .margin(const EdgeInsets.symmetric(
                                            horizontal: 4))
                                            .padding(const EdgeInsets.all(8))
                                            .make().onTap(() {
                                              Get.to(()=>ItemDetail(title: "${featuredData[index]['p_name']}", data: featuredData[index]));
                                            })),
                                  );

                                }

                              },
                            )
                          )
                        ],
                      ),
                    ),
                    20.heightBox,

                    //third swapper
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        height: 170,
                        enlargeCenterPage: true,
                        itemCount: SecondbrandList.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            SecondbrandList[index],
                            fit: BoxFit.fill,
                          )
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(const EdgeInsets.symmetric(horizontal: 8))
                              .make();
                        }),

                    //All products section
                    20.heightBox,
                    "All Products".text.fontFamily(bold).color(darkFontGrey).size(22).make(),
                    20.heightBox,
                    //all products from db
                    StreamBuilder(
                        stream: FirestoreServices.getAllProducts(),
                        builder: (BuildContext  context, AsyncSnapshot<QuerySnapshot> snapshot){
                          if(!snapshot.hasData){
                            return LoadingIndicator();
                          }else{
                            var allProductData=snapshot.data!.docs;
                            return GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: allProductData.length,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8,
                                    mainAxisExtent: 300
                                ),
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Image.network(
                                        allProductData[index]['p_images'][0],
                                        width: 190,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                      Spacer(),
                                      "${allProductData[index]['p_name']}"
                                          .text
                                          .color(darkFontGrey)
                                          .fontFamily(regular)
                                          .make(),
                                      10.heightBox,
                                      "${allProductData[index]['p_price']}".numCurrency
                                          .text
                                          .color(redColor)
                                          .fontFamily(bold)
                                          .make(),
                                    ],
                                  ).box
                                      .white
                                      .rounded
                                      .margin(const EdgeInsets.symmetric(
                                      horizontal: 4))
                                      .padding(const EdgeInsets.all(12))
                                      .make().onTap(() {
                                        Get.to(()=>ItemDetail(title: "${allProductData[index]['p_name']}", data: allProductData[index]));
                                  });
                                });
                          }
                        }
                    )

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
