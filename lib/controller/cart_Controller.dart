import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/controller/home_controller.dart';
import 'package:get/get.dart';
class CartController extends GetxController{
  var totalPrice=0.obs;

  var vendors=[];

  calculate(data){
totalPrice.value=0;
    for(int i=0; i < data.length;i++){
      totalPrice.value=totalPrice.value+int.parse(data[i]['tprice'].toString());
    }
  }


  //text controllers for shipping screen

var addressController=TextEditingController();
  var cityController=TextEditingController();
  var stateController=TextEditingController();
  var postalCodeController=TextEditingController();
  var phoneController=TextEditingController();

  var paymentIndex=0.obs;

  changePaymentIndex(index){
    paymentIndex.value=index;
  }

late dynamic productSnapshot;
var products=[];
var placingOrder=false.obs;
  //placing order

placeMyOrder({required orderPaymentMethod, required totalAmuont}) async{
placingOrder(true);
  await getProductDetails();

    await firestore.collection(ordersCollection).doc().set({
      'order_code':"234567891",
      'order_date': FieldValue.serverTimestamp(),
      'order_by': currentUser!.uid,
      'order_by_name':Get.find<HomeController>().username,
      'order_by_email': currentUser!.email,
      'order_by_address':addressController.text,
      'order_by_state':stateController.text,
      'order_by_city':cityController.text,
      'order_by_phone':phoneController.text,
      'order_by_postalcode':postalCodeController.text,
      'shipping_method': "Home Delivery",
      'payment_method':orderPaymentMethod,
      'order_placed':true,
      'order_confirmed':false,
      'order_delivered':false,
      'order_on_delivery': false,
      'total_amount':totalAmuont,
      'orders':FieldValue.arrayUnion(products),
      'vendors':FieldValue.arrayUnion(vendors),
    });
    placingOrder(false);
}

getProductDetails(){
  products.clear();
  vendors.clear();
  for(var i=0; i<productSnapshot.length; i++){
    products.add({
      'color': productSnapshot[i]['color'],
      'img':productSnapshot[i]['img'],
      'title':productSnapshot[i]['title'],
      'qty':productSnapshot[i]['qty'],
      'vendor_id': productSnapshot[i]['vendor_id'],
      'tprice':productSnapshot[i]['tprice']
    });
    
    vendors.add(productSnapshot[i]['vendor_id']);

  }
}


clearCart(){
  for(var i=0; i< productSnapshot.length;i++){
    firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
  }
}
}