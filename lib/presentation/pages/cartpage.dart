import 'package:champ/functions/func.dart';
import 'package:champ/models/cartmodel.dart';
import 'package:champ/presentation/colors/mycolors.dart';
import 'package:champ/presentation/textstyle.dart';
import 'package:champ/presentation/widgets/arrowicon.dart';
import 'package:champ/presentation/widgets/button.dart';
import 'package:champ/presentation/widgets/cartitem.dart';
import 'package:champ/presentation/widgets/checkout.dart';
import 'package:champ/presentation/widgets/ordernotification.dart';
import 'package:champ/riverpod/addressprovider.dart';
import 'package:champ/riverpod/cartprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

double delivery = 0;
double total = 0;
bool? isReadyForCheckout;

class _CartPageState extends ConsumerState<CartPage> {
  @override
  void initState() {
    Future.microtask(() => ref.watch(cartProvider.notifier).updateCartSum());
    isReadyForCheckout = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final address = ref.watch(addressProvider);
    final cart = ref.watch(cartProvider);
    final cartSum = ref.watch(cartSumProvider);
    final cartDelivery = ref.watch(cartDeliveryProvider);
    final cartTotal = ref.watch(cartTotalProvider);
    return Scaffold(
      backgroundColor: MyColors.background,
      appBar: AppBar(
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Text(
          'Корзина',
          textAlign: TextAlign.start,
          style: myTextStyle(16, MyColors.text, null),
        ),
        leading: Container(
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: MyColors.block, borderRadius: BorderRadius.circular(30)),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: ArrowIcon(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              !isReadyForCheckout!
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              Text(
                                '${cart.length} товаров',
                                textAlign: TextAlign.start,
                                style: myTextStyle(16, MyColors.text, null),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height - 400,
                          width: MediaQuery.of(context).size.width - 20,
                          child: ListView.builder(
                              itemCount: cart.length,
                              itemBuilder: (context, index) {
                                var keys = cart.keys.toList();
                                if (keys.isEmpty) {
                                  return const Center(
                                    child: Text(
                                      'no sneaker',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  );
                                } else {
                                  var sneaker = cart[keys[index]];
                                  return CartItem(
                                    id: sneaker!.id,
                                    image: sneaker.image!,
                                    name: sneaker.name,
                                    price: sneaker.price,
                                    count: sneaker.count!,
                                  );
                                }
                              }),
                        ),
                      ],
                    )
                  : Checkout(),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                decoration: BoxDecoration(
                  color: MyColors.block,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Сумма:',
                          style: myTextStyle(18, MyColors.subtextdark, null),
                        ),
                        Text(
                          '₽$cartSum',
                          style: myTextStyle(18, MyColors.text, null),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Доставка:',
                          style: myTextStyle(18, MyColors.subtextdark, null),
                        ),
                        Text(
                          '₽$cartDelivery',
                          style: myTextStyle(18, MyColors.text, null),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Image.asset('assets/horizontal_divider.png'),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Итого:',
                          style: myTextStyle(18, MyColors.text, null),
                        ),
                        Text(
                          '₽$cartTotal',
                          style: myTextStyle(18, MyColors.accent, null),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Button(
                        title: isReadyForCheckout!
                            ? 'Подтвердить'
                            : 'Оформить заказ',
                        controller: null,
                        bgcolor: MyColors.accent,
                        titlecolor: Colors.white,
                        onTap: () async {
                          if (!isReadyForCheckout!) {
                            if (cart.isNotEmpty) {
                              setState(() {
                                isReadyForCheckout = true;
                              });
                            }
                          } else {
                            var result = await Func().createOrder(ref);
                            if (result) {
                              showCupertinoModalPopup(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) =>
                                    orderNotification(context),
                              );
                            }
                          }
                        })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
