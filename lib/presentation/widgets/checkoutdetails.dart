import 'dart:developer';

import 'package:champ/functions/func.dart';
import 'package:champ/presentation/colors/mycolors.dart';
import 'package:champ/presentation/pages/editprofilepage.dart';
import 'package:champ/presentation/textstyle.dart';
import 'package:champ/riverpod/addressprovider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CheckoutDetail extends ConsumerStatefulWidget {
  const CheckoutDetail({super.key, required this.address});

  final String address;
  @override
  ConsumerState<CheckoutDetail> createState() => _CheckoutState();
}

bool? isEditableForMail;
bool? isEditableForPhone;
String? selectedText;
String? selectedKey;
TextEditingController mailController = TextEditingController();
TextEditingController phoneController = TextEditingController();
LocationSettings? locationSettings;

class _CheckoutState extends ConsumerState<CheckoutDetail> {
  @override
  void initState() {
    mailController.text = Supabase.instance.client.auth.currentUser!.email!;
    phoneController.text =
        Supabase.instance.client.auth.currentUser!.userMetadata!['phoneNumber'];
    locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.best,
      distanceFilter: 100,
    );
    isEditableForMail = true;
    isEditableForPhone = true;
    selectedText = widget.address;
    selectedKey = 'firstCard'; // Инициализируем с одним из ключей Map
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> map = {
      'firstCard': {
        'nameCard': 'DbL Card',
        'numCard': '**** **** 0696 4629',
      },
      'secondCard': {
        'nameCard': 'VISA Card',
        'numCard': '**** **** 7743 2123',
      },
    };
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: SingleChildScrollView(
        // Добавляем SingleChildScrollView
        child: Container(
          padding: const EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width - 20,
          height: MediaQuery.of(context).size.height - 430,
          decoration: BoxDecoration(
            color: MyColors.block,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Контактная информация',
                style: myTextStyle(14, MyColors.text, null),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/checkout_mail.png',
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 250,
                            height: 20,
                            child: TextField(
                              maxLines: 1,
                              controller: mailController,
                              keyboardType: TextInputType.emailAddress,
                              readOnly: isEditableForMail!,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: myTextStyle(14, MyColors.text, null),
                                hintText: '*******@****.***',
                                contentPadding: EdgeInsets.only(bottom: 14),
                              ),
                            ),
                          ),
                          Text(
                            'Email',
                            style: myTextStyle(14, MyColors.subtextdark, null),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/checkout_phone.png',
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 150,
                            height: 20,
                            child: TextField(
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              readOnly: isEditableForPhone!,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: myTextStyle(14, MyColors.text, null),
                                hintText: '**-***-***-****',
                                //contentPadding: EdgeInsets.only(bottom: 14),
                              ),
                            ),
                          ),
                          Text(
                            'Телефон',
                            style: myTextStyle(14, MyColors.subtextdark, null),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                'Адрес',
                style: myTextStyle(14, MyColors.text, null),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        selectedText!,
                        style: myTextStyle(14, MyColors.subtextdark, null),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Image.asset('assets/checkout_map.png'),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Способ оплаты',
                style: myTextStyle(14, MyColors.text, null),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/checkout_cardicon.png',
                        width: 40,
                        height: 40,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            map[selectedKey]['nameCard'],
                            style: myTextStyle(14, MyColors.text, null),
                          ),
                          Text(
                            map[selectedKey]['numCard'],
                            style: myTextStyle(14, MyColors.subtextdark, null),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
