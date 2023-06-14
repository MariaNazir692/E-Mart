import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/views/profile_screen/orderScreen/component/orderStatus.dart';
import 'component/order_placed_details.dart';
import 'package:intl/intl.dart' as intl;


class OrdersDetail extends StatelessWidget {
  final dynamic data;
  const OrdersDetail({Key? key,  required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        title: "Order Details".text.color(redColor).fontFamily(semibold).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              OrderStatus(icon:Icons.done,
                  title: "Placed",
                  color: redColor,
                  showDone: data['order_placed']
              ),
              OrderStatus(icon:Icons.thumb_up,
                  title: "Confirmed",
                  color: Colors.blue,
                  showDone: data['order_confirmed']
              ),
              OrderStatus(icon:Icons.car_rental,
                  title: "On Delivery",
                  color: Colors.yellow,
                  showDone: data['order_on_delivery']
              ),
              OrderStatus(icon:Icons.done_all,
                  title: "Delivered",
                  color: Colors.purple,
                  showDone: data['order_delivered']
              ),

              Divider(
                thickness: 2,
              ),
              10.heightBox,
            Column(
              children: [
                orderPlacedDetails(
                    d1: data['order_code'],
                    d2: data['shipping_method'],
                    title1: "Order Code",
                    title2: "Shipping Method"
                ),
                orderPlacedDetails(
                    d1: intl.DateFormat().add_yMd().format(data['order_date'].toDate()),
                    d2: data['payment_method'],
                    title1: "Order Date",
                    title2: "Payment Method"
                ),
                orderPlacedDetails(
                    d1: "UnPaid",
                    d2: "Order Placed",
                    title1: "Payment Status",
                    title2: "Delivery Status"
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "Shipping Address".text.fontFamily(semibold).make(),
                          "${data['order_by_name']}".text.make(),
                          "${data['order_by_email']}".text.make(),
                          "${data['order_by_address']}".text.make(),
                          "${data['order_by_city']}".text.make(),
                          "${data['order_by_state']}".text.make(),
                          "${data['order_by_phone']}".text.make(),
                          "${data['order_by_postalcode']}".text.make(),
                        ],
                      ),
                      SizedBox(
                        width: 130,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Total Amount".text.fontFamily(semibold).make(),
                            "${data['total_amount']}".numCurrency.text.color(redColor).fontFamily(semibold).make()
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ).box.roundedSM.shadowSm.white.make(),
              const Divider(
                thickness: 2,
              ),
              20.heightBox,
              "Ordered Product".text.fontFamily(semibold).color(darkFontGrey).size(18).makeCentered(),
              10.heightBox,
              ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(data['orders'].length, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      orderPlacedDetails(
                        title1: data['orders'][index]['title'],
                        title2:data['orders'][index]['tprice'],
                        d1: "${data['orders'][index]['qty']}x",
                        d2: "Refundable"
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          width: 30,
                          height: 10,
                          color: Color(data['orders'][index]['color']),
                        ),
                      ),
                      10.heightBox
                    ],
                  );
                }).toList(),
              ).box.white.shadowSm.make(),
              30.heightBox
              
            ],
          ),
        ),
      ),
    );
  }
}
