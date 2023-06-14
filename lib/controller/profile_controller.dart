import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController{

  resetControllers(){
    nameController.clear();
    oldpassController.clear();
    newpassController.clear();
  }

  var profileImagePath=''.obs;
  var nameController=TextEditingController();
  var oldpassController=TextEditingController();
  var newpassController=TextEditingController();
  var profileImageDownloadLink='';
  var isloading=false.obs;

  changeImage(context)async{
    try{
      final img=await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 70);
      if(img==null)return;
      profileImagePath.value=img.path;
    }on PlatformException catch(e){
      VxToast.show(context, msg: e.toString());
    }

  }

  UploadProfileImage()async{
    var filename=basename(profileImagePath.value);
    var destination='images/${currentUser!.uid}/$filename';
    Reference ref=FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImagePath.value));
    profileImageDownloadLink=await ref.getDownloadURL();
  }

  updateProfile({name, password, imageUrl})async{

    var store=firestore.collection(userCollection).doc(currentUser!.uid);
    store.set({
      'name':name,
      'password':password ,
      'photoUrl':imageUrl

    },SetOptions(merge:true));
    isloading(false);
  }

  changeAuthPassword({email,password, newPassword})async{
    final cred=EmailAuthProvider.credential(email: email, password: password);
    await currentUser!.reauthenticateWithCredential(cred).then((value){
      currentUser!.updatePassword(newPassword);
    }).catchError((error){
      print(error.toString());
    });
  }
}