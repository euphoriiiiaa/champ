import 'dart:developer';

import 'package:champ/functions/func.dart';
import 'package:champ/presentation/colors/mycolors.dart';
import 'package:champ/presentation/pages/orderdetails.dart';
import 'package:champ/presentation/textstyle.dart';
import 'package:champ/presentation/widgets/arrowicon.dart';
import 'package:champ/presentation/widgets/orderitem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:humanize_duration/humanize_duration.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

String address = '';

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      appBar: AppBar(
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Text(
          'Заказы',
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
        child: FutureBuilder(
          future: Func().getOrders(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No orders found.'));
            } else {
              var orders = snapshot.data!;
              return Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                width: 500,
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => OrderDetails(
                                  address: orders[index]['address'],
                                  title: orders[index]['id'].toString(),
                                  date: DateTime.parse(
                                                  orders[index]['created_at'])
                                              .day ==
                                          DateTime.now().day
                                      ? '${humanizeDuration(
                                          language: const RuLanguage(),
                                          Duration(
                                            minutes: (DateTime.now().minute -
                                                DateTime.parse(orders[index]
                                                        ['created_at'])
                                                    .minute),
                                          ),
                                        )} назад'
                                      : ('${DateTime.parse(orders[index]['created_at']).hour}asd:${DateTime.parse(orders[index]['created_at']).minute}'),
                                  orderid: orders[index]['id'])));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateTime.parse(orders[index]['created_at']).day ==
                                  DateTime.now().day
                              ? 'Недавно (№ ${orders[index]['id']})'
                              : '${humanizeDuration(
                                  language: const RuLanguage(),
                                  Duration(
                                    days: DateTime.now().day -
                                        DateTime.parse(
                                                orders[index]['created_at'])
                                            .day,
                                  ),
                                )} назад (№ ${orders[index]['id']})',
                          style: myTextStyle(18, MyColors.text, null),
                        ),
                        FutureBuilder(
                          future: Func().getOrderSneakers(orders[index]['id']),
                          builder: (context, snapshot2) {
                            if (snapshot2.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot2.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot2.error}'));
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
                                  return OrderItem(
                                      idorder: orders[index]['id'],
                                      createdat: orders[index]['created_at'],
                                      sneakername:
                                          ordersneakers[indexx].sneakername!,
                                      total: orders[index]['sum'],
                                      image: ordersneakers[indexx].image!);
                                },
                              );
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
