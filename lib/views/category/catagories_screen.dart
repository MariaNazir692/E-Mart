import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/consts/lists.dart';
import 'package:e_mart/views/category/category_details.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../common_widgets/bg_widget.dart';
import '../../controller/productController.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller=Get.put(ProductController());

    return BgWidget(Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: categories.text.white.fontFamily(bold).make(),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          shrinkWrap: true,
            itemCount: 9,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    mainAxisExtent: 200,
                    crossAxisCount: 3,
                ),
            itemBuilder: (context, index){
              return Column(
                children:  [
                  Image.asset(categoriesImage[index], width: 200,height: 120, fit: BoxFit.cover,),
                  categoriesList[index].text.color(darkFontGrey).align(TextAlign.center).make(),
                ],
              ).box.rounded.outerShadowSm.clip(Clip.antiAlias).white.make().onTap(() {
                
                controller.getSubCategories(categoriesList[index]);
                Get.to(()=>CategoryDetails(title: categoriesList[index]));
              });
            }),
      ),
    ));
  }
}
