import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/controller/productController.dart';
import 'package:e_mart/views/category/category_details.dart';
import 'package:get/get.dart';

Widget FeaturedButton({String? title, icon}) {
  var controller=Get.put(ProductController());
  return Row(
    children: [
      Image.asset(
        icon,
        width: 60,
        height: 60,
        fit: BoxFit.fill,
      ),
      10.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  )
      .box.width(300)
      .margin(EdgeInsets.symmetric(horizontal: 4))
      .padding(EdgeInsets.all(8))
      .roundedSM
      .white
      .outerShadowSm
      .make().onTap(() {
        controller.getSubCategories(title);
        Get.to(()=>CategoryDetails(title: title));});
}
