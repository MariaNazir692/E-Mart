import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart/common_widgets/bg_widget.dart';
import 'package:e_mart/common_widgets/loadingIndicator.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/controller/auth_controller.dart';
import 'package:e_mart/controller/profile_controller.dart';
import 'package:e_mart/views/auth_screens/loginScreen.dart';
import 'package:e_mart/views/profile_screen/edit_prfile/Edit_profileScreen.dart';
import 'package:e_mart/views/profile_screen/messageingScreen/messagingScreen.dart';
import 'package:e_mart/views/profile_screen/wishListScreen/wishListScreen.dart';

import 'package:get/get.dart';

import '../../consts/lists.dart';
import '../../services/firestore_services.dart';

import 'componenet/card_detail.dart';
import 'orderScreen/order_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(ProfileController());
    return BgWidget(Scaffold(
      body: StreamBuilder(
        stream: FirestoreServices.getUser(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor),),);
          }else {

            var data=snapshot.data!.docs[0];
            return SafeArea(
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    //User Detail Section
                    Row(
                      children: [
                        data['photoUrl']==''?
                        Image.asset(
                          imgP1,
                          fit: BoxFit.cover,
                          width: 70,
                        ).box.roundedFull.clip(Clip.antiAlias).make():
                        Image.network(
                          data['photoUrl'],
                          fit: BoxFit.cover,
                          width: 70,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
                        10.widthBox,
                        Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "${data['name']}".text.white.fontFamily(semibold).make(),
                                5.heightBox,
                                "${data['email']}".text.white.fontFamily(regular).make(),
                              ],
                            )),
                        OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Colors.white)),
                            onPressed: () async{
                              await Get.put(AuthController()).signOutMethod(context);
                              Get.offAll(()=>logInScreen());
                            },
                            child: "LogOut".text.fontFamily(semibold).white.make())
                      ],
                    ),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.white)),
                        onPressed: () {
                          controller.nameController.text=data['name'];

                          Get.to(()=>EditProfileScreen(data: data,));
                        },
                        child: "Edit Profile".text.fontFamily(semibold).white.make()),
                    10.heightBox,
                    FutureBuilder(
                      future: FirestoreServices.getCounts(),
                        builder: (BuildContext context, AsyncSnapshot snapshot){
                        if(!snapshot.hasData){
                          return Center(child: LoadingIndicator(),);
                        }else {
                          var countData=snapshot.data;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CardDetail(
                                  title: "Your Cart",
                                  count: countData[0].toString(),
                                  width: context.screenWidth / 3.4),
                              CardDetail(
                                  title: "Your Wishlist",
                                  count: countData[1].toString(),
                                  width: context.screenWidth / 3.4),
                              CardDetail(
                                  title: "Your Orders",
                                  count: countData[2].toString(),
                                  width: context.screenWidth / 3.4),
                            ],
                          );
                        }
                      }
                    ),

                    //profile btn
                    30.heightBox,

                    ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index){
                        return const Divider(
                          color: lightGrey,
                        );
                      },
                      itemCount: ProfilebtnList.length,
                      itemBuilder: (BuildContext context, int index){
                        return ListTile(
                          onTap: (){
                            switch(index){
                              case 0:
                                Get.to(()=>OrderScreen());
                                break;
                              case 1:
                                Get.to(()=>WishListScreen());
                                break;
                              case 2:
                                Get.to(()=>MessageScreen());
                                break;
                              default:
                            }
                          },
                          title: ProfilebtnList[index].text.make(),
                          leading: Image.asset(ProfilebtnIcn[index], width: 22,),
                        );

                      },

                    ).box.rounded.white.padding(EdgeInsets.symmetric(horizontal: 16)).shadowSm.make()

                  ],
                ),
              ),
            );
          }


        },

      )
    ));
  }
}
