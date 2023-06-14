import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{

  var emailController = TextEditingController();
  var passController = TextEditingController();

  var isloading=false.obs;


  //loginMethod
  Future<UserCredential?> loginMethod({ context})async{
    UserCredential? userCredential;
    try{
     userCredential= await auth.signInWithEmailAndPassword(email: emailController.text, password: passController.text);
    }on FirebaseAuthException catch(e){
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //signUp method
  Future<UserCredential?> signUpMethod({email, password, context})async{
    UserCredential? userCredential;
    try{
      userCredential= await auth.createUserWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException catch(e){
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  storeUserDate({name, email, password})async{
    await firestore.collection(userCollection).doc(currentUser!.uid).set(
        {
          'name': name,
          'email':email,
          'password':password,
          'photoUrl':'',
          'id':currentUser!.uid,
          'cart_count':"00",
          'order_count':"00",
          'wishlist':"00",
        });
  }

  signOutMethod(context)async{
    try{
      await auth.signOut();
    }catch(e){
      VxToast.show(context, msg: e.toString());
    }
  }
}