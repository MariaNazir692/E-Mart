import 'package:e_mart/common_widgets/customBtn.dart';
import 'package:e_mart/common_widgets/custom_formFields.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/controller/cart_Controller.dart';
import 'package:e_mart/views/shippingScreens/paymentMethodScreen.dart';
import 'package:get/get.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        title: "Shipping Info"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: CustomBtn(
          color: redColor,
          title: "Contine",
          textColor: whiteColor,
          onPress: () {
            if (controller.addressController.text.length > 10 &&
                controller.cityController.text.isNotEmpty &&
                controller.stateController.text.isNotEmpty &&
                controller.postalCodeController.text.isNotEmpty &&
                controller.phoneController.text.length == 11) {
              Get.to(()=>PaymentMethodScreen());

            } else {
              VxToast.show(context, msg: "Please fill out the Form to continue");
            }
          }),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            CustomTextFields(
                title: "Address",
                hint: "Address",
                isPass: false,
                controller: controller.addressController),
            CustomTextFields(
                hint: "City",
                isPass: false,
                title: "City",
                controller: controller.cityController),
            CustomTextFields(
                hint: "State",
                isPass: false,
                title: "State",
                controller: controller.stateController),
            CustomTextFields(
                hint: "Postal Code",
                isPass: false,
                title: "Postal Code",
                controller: controller.postalCodeController),
            CustomTextFields(
                hint: "Phone",
                isPass: false,
                title: "Phone",
                controller: controller.phoneController),
          ],
        ),
      ),
    );
  }
}
