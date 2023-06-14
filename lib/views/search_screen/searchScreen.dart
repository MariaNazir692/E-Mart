import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart/common_widgets/loadingIndicator.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/services/firestore_services.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../category/item_details.dart';

class SearchScreen extends StatelessWidget {
  final String? title;

  const SearchScreen({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: title!.text.color(darkFontGrey).make(),
        elevation: 0,
      ),
      body: FutureBuilder(
        future: FirestoreServices.getSearchResult(title),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: LoadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "Not found any product".text.makeCentered();
          } else {
            var data = snapshot.data!.docs;
            var filtered = data
                .where((element) => element['p_name']
                    .toString()
                    .toLowerCase()
                    .contains(title!.toLowerCase()))
                .toList();
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    mainAxisExtent: 300),
                children: filtered
                    .mapIndexed((currentValue, index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              filtered[index]['p_images'][0],
                              width: 190,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                            Spacer(),
                            "${filtered[index]['p_name']}"
                                .text
                                .color(darkFontGrey)
                                .fontFamily(regular)
                                .make(),
                            10.heightBox,
                            "${filtered[index]['p_price']}"
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
                          Get.to(() => ItemDetail(
                              title: "${filtered[index]['p_name']}",
                              data: filtered[index]));
                        }))
                    .toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
