import 'package:champ/functions/func.dart';
import 'package:champ/presentation/colors/mycolors.dart';
import 'package:champ/presentation/textstyle.dart';
import 'package:champ/presentation/widgets/arrowicon.dart';
import 'package:champ/presentation/widgets/checkout.dart';
import 'package:champ/presentation/widgets/checkoutdetails.dart';
import 'package:champ/presentation/widgets/orderdetailsitem.dart';
import 'package:champ/presentation/widgets/orderitem.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails(
      {super.key,
      required this.title,
      required this.date,
      required this.orderid,
      required this.address});

  final String title;
  final String date;
  final int orderid;
  final String address;
  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      appBar: AppBar(
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Text(
          '№ ${widget.title}',
          textAlign: TextAlign.start,
          style: myTextStyle(16, MyColors.text, null),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Container(
            child: const ArrowIcon(),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: MyColors.block, borderRadius: BorderRadius.circular(20)),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.date,
                    style: myTextStyle(14, MyColors.hint, null),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder(
                    future: Func().getOrderSneakers(widget.orderid),
                    builder: (context, snapshot2) {
                      if (snapshot2.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot2.hasError) {
                        return Center(child: Text('Error: ${snapshot2.error}'));
                      } else if (!snapshot2.hasData ||
                          snapshot2.data!.isEmpty) {
                        return const Center(
                            child: Text('No ordersneakers found.'));
                      } else {
                        var ordersneakers = snapshot2.data!;
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: ordersneakers.length,
                          itemBuilder: (context, indexx) {
                            return OrderDetailsItem(
                              count: ordersneakers[indexx].count,
                              sneakername: ordersneakers[indexx].sneakername!,
                              cost: ordersneakers[indexx].cost!,
                              image: ordersneakers[indexx].image!,
                            );
                          },
                        );
                      }
                    },
                  )
                ],
              ),
              CheckoutDetail(
                address: widget.address,
              )
            ],
          ),
        ),
      ),
    );
  }
}
