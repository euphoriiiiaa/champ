import 'package:champ/models/cartmodel.dart';
import 'package:champ/presentation/colors/mycolors.dart';
import 'package:champ/presentation/textstyle.dart';
import 'package:champ/presentation/widgets/arrowicon.dart';
import 'package:champ/presentation/widgets/button.dart';
import 'package:champ/presentation/widgets/cartitem.dart';
import 'package:champ/riverpod/cartprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

double sum = 0;
double delivery = 0;
double total = 0;

class _CartPageState extends ConsumerState<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
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
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 400,
              width: MediaQuery.of(context).size.width - 80,
              child: ListView.builder(
                  itemCount: CartModel.cart.length,
                  itemBuilder: (context, index) {
                    var keys = CartModel.cart.keys.toList();
                    if (keys.isEmpty) {
                      return const Center(
                        child: Text(
                          'no sneaker',
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    } else {
                      var sneaker = CartModel.cart[keys[index]];
                      return CartItem(
                        id: sneaker!.id,
                        image: sneaker.image,
                        name: sneaker.name,
                        price: sneaker.price,
                        count: sneaker.count!,
                      );
                    }
                  }),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
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
                          '₽$sum',
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
                          '₽$delivery',
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
                          '₽$total',
                          style: myTextStyle(18, MyColors.accent, null),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Button(
                        title: "Оформить заказ",
                        controller: null,
                        bgcolor: MyColors.accent,
                        titlecolor: Colors.white,
                        onTap: () {})
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
