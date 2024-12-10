import 'dart:developer';
import 'dart:io';

import 'package:champ/api/kand.dart';
import 'package:champ/data/data.dart';
import 'package:champ/functions/func.dart';
import 'package:champ/presentation/colors/mycolors.dart';
import 'package:champ/presentation/textstyle.dart';
import 'package:champ/presentation/widgets/arrowicon.dart';
import 'package:champ/presentation/widgets/textboxprofile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

TextEditingController name = TextEditingController();
TextEditingController surname = TextEditingController();
TextEditingController address = TextEditingController();
TextEditingController number = TextEditingController();
Uint8List? _image;

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  void initState() {
    super.initState();
    if (Supabase.instance.client.auth.currentUser != null) {
      name.text =
          Supabase.instance.client.auth.currentUser!.userMetadata!['name'];
      surname.text =
          Supabase.instance.client.auth.currentUser!.userMetadata!['surname'];
      address.text =
          Supabase.instance.client.auth.currentUser!.userMetadata!['address'];
      number.text = Supabase
          .instance.client.auth.currentUser!.userMetadata!['phoneNumber'];
      Future.microtask(() async {
        _image = await Func().getImageFromStorage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      appBar: AppBar(
          centerTitle: true,
          forceMaterialTransparency: true,
          title: GestureDetector(
            onTap: () {
              Func().changeUserInfo(
                  name.text, surname.text, address.text, number.text, context);
            },
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width - 200,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: MyColors.accent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Сохранить',
                style: myTextStyle(14, Colors.white, null),
              ),
            ),
          )),
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
                  child: FutureBuilder(
                    future: Func().getImageFromStorage(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (!snapshot.hasData) {
                        return Image.asset(
                          'assets/avatar.png',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        );
                      } else {
                        final image = snapshot.data;
                        return Image.memory(
                          image!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        );
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                Supabase.instance.client.auth.currentUser != null
                    ? Supabase
                        .instance.client.auth.currentUser!.userMetadata!['name']
                    : '',
                textAlign: TextAlign.start,
                style: myTextStyle(20, MyColors.text, null),
              ),
              GestureDetector(
                onTap: () async {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            'Выберите способ',
                            style: myTextStyle(
                                14, MyColors.text, TextDecoration.none),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Func().cameraImage();
                                Navigator.pop(context);
                              },
                              child: Text('Camera'),
                            ),
                            TextButton(
                              onPressed: () {
                                Func().galleryImage();
                                Navigator.pop(context);
                              },
                              child: Text('Gallery'),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text('Kand'),
                            ),
                          ],
                        );
                      });
                },
                child: Text(
                  'Изменить фото профиля',
                  textAlign: TextAlign.start,
                  style: myTextStyle(12, MyColors.accent, null),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              GestureDetector(
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => Center(
                      child: Container(
                        alignment: Alignment.center,
                        height: 100,
                        width: MediaQuery.of(context).size.width - 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          'UUID: ${Supabase.instance.client.auth.currentUser!.id}',
                          style: myTextStyle(
                              16, Colors.black, TextDecoration.none),
                        ),
                      ),
                    ),
                  );
                },
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
                            symbology: Code39Extended(module: 2),
                            value:
                                Supabase.instance.client.auth.currentUser!.id),
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
                isEditable: true,
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
                isEditable: true,
                hint: 'Фамилия',
                textinputtype: TextInputType.text,
                controller: surname,
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
                isEditable: true,
                hint: 'Адрес',
                textinputtype: TextInputType.streetAddress,
                controller: address,
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
                isEditable: true,
                hint: 'Телефон',
                textinputtype: TextInputType.phone,
                controller: number,
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
