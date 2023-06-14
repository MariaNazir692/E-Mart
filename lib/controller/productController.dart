import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../model/categoryModel.dart';

class ProductController extends GetxController{

  //quantity of product
  var quantity=0.obs;
  //for color
  var colorIndex=0.obs;

  //for total
  var totalPrice=0.obs;

  var isFav=false.obs;

  //list of sub categories
  var subcat=[];
  //getting sub categories for showing it according to the main category
  getSubCategories(title)async{
    subcat.clear();
    var data=await rootBundle.loadString("lib/services/category_model.json");
    var decoded=categoryModelFromJson(data);
    var s=decoded.categories.where((element) => element.name==title).toList();
    for(var e in s[0].subcategory){
      subcat.add(e);
    }
  }

  changeColorIndex(index){
    colorIndex.value=index;
  }

  increaseQuantity(totalQuantity){
    if(quantity.value<totalQuantity){
      quantity.value++;
    }

  }

  decreaseQuantity(){
    if(quantity.value>0){
      quantity.value--;
    }

  }
  calculateTotalPrice(price){
    totalPrice.value=price*quantity.value;
  }

  addToCart({title, img, qty, sellername,color, tprice,context,vendorId})async{
    await firestore.collection(cartCollection).doc().set({
      "title": title,
     "img":img,
      "qty":qty,
      "color":color,
      "tprice":tprice,
      "sellername":sellername,
      "added_by":currentUser!.uid,
      'vendor_id':vendorId
    }).catchError((error){
      VxToast.show(context, msg:error.toString());
    });
  }

  resetValues(){
    colorIndex.value=0;
    totalPrice.value=0;
    quantity.value=0;
  }

  //add product to wishlist

addToWishList(docId,context)async{
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist':FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(true);
    VxToast.show(context, msg: "Added to wishlist");
}

//delete from wishlist
  removeFromWishList(docId, context)async{
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist':FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(false);
    VxToast.show(context, msg: "Removed from wishlist");
  }

  checkIfFav(data)async{
    if(data['p_wishlist'].contains(currentUser!.uid)){
      isFav(true);
    }else{
      isFav(false);
    }

  }


}