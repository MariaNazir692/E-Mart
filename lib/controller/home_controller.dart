import 'package:e_mart/consts/consts.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUserName();
  }

  var currentNavIndex=0.obs;

  var username='';

  var searchController=TextEditingController();

  getUserName()async{
    var  n= await firestore.collection(userCollection).where('id', isEqualTo: currentUser!.uid).get().then((value){
      if(value.docs.isNotEmpty){
        return value.docs.single['name'];
      }
    });
    username=n;
  }

}