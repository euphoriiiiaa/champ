import 'package:champ/data/data.dart';
import 'package:champ/presentation/colors/mycolors.dart';
import 'package:champ/presentation/textstyle.dart';
import 'package:champ/presentation/widgets/arrowicon.dart';
import 'package:champ/presentation/widgets/textboxprofile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

TextEditingController name = TextEditingController();
TextEditingController surname = TextEditingController();
TextEditingController address = TextEditingController();
TextEditingController number = TextEditingController();

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      appBar: AppBar(
        centerTitle: true,
        forceMaterialTransparency: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {},
              child: Text(
                'Готово',
                textAlign: TextAlign.start,
                style: myTextStyle(15, MyColors.accent, null),
              ),
            ),
          )
        ],
        title: Text(
          'Профиль',
          textAlign: TextAlign.start,
          style: myTextStyle(16, MyColors.text, null),
        ),
        leading: Container(
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30)),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: ArrowIcon(),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: ClipOval(
                  child: Image.asset(
                    width: 96,
                    height: 96,
                    'assets/first_onboard.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Emmanuel Oyiboke',
                textAlign: TextAlign.start,
                style: myTextStyle(20, MyColors.text, null),
              ),
              Text(
                'Изменить фото профиля',
                textAlign: TextAlign.start,
                style: myTextStyle(12, MyColors.accent, null),
              ),
              const SizedBox(
                height: 12,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width - 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          'Открыть',
                          textAlign: TextAlign.start,
                          style: myTextStyle(12, MyColors.text, null),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 100,
                        height: 50,
                        child: SfBarcodeGenerator(
                            barColor: Colors.black,
                            symbology: Code128B(),
                            value: '123121123233'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    'Имя',
                    textAlign: TextAlign.start,
                    style: myTextStyle(20, MyColors.text, null),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextBoxProfile(
                hint: 'Имя',
                textinputtype: TextInputType.text,
                controller: name,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    'Фамилия',
                    textAlign: TextAlign.start,
                    style: myTextStyle(20, MyColors.text, null),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextBoxProfile(
                hint: 'Фамилия',
                textinputtype: TextInputType.text,
                controller: name,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    'Адрес',
                    textAlign: TextAlign.start,
                    style: myTextStyle(20, MyColors.text, null),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextBoxProfile(
                hint: 'Адрес',
                textinputtype: TextInputType.text,
                controller: name,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    'Телефон',
                    textAlign: TextAlign.start,
                    style: myTextStyle(20, MyColors.text, null),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextBoxProfile(
                hint: 'Телефон',
                textinputtype: TextInputType.text,
                controller: name,
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
