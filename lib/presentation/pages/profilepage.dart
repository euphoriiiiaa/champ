import 'package:champ/data/data.dart';
import 'package:champ/functions/func.dart';
import 'package:champ/presentation/colors/mycolors.dart';
import 'package:champ/presentation/pages/editprofilepage.dart';
import 'package:champ/presentation/textstyle.dart';
import 'package:champ/presentation/widgets/arrowicon.dart';
import 'package:champ/presentation/widgets/textboxprofile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
String? nameProfile;
String uuid = Supabase.instance.client.auth.currentUser!.id;
Uint8List? _image;

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    Supabase.instance.client.auth.refreshSession();
    name.text =
        Supabase.instance.client.auth.currentUser!.userMetadata!['name'];
    surname.text =
        Supabase.instance.client.auth.currentUser!.userMetadata!['surname'];
    address.text =
        Supabase.instance.client.auth.currentUser!.userMetadata!['address'];
    number.text =
        Supabase.instance.client.auth.currentUser!.userMetadata!['phoneNumber'];
    nameProfile = name.text;
    Future.microtask(() async {
      _image = await Func().getImageFromStorage();
    });
  }

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
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => EditProfilePage(),
                    ),
                  );
                  setState(() {});
                },
                child: Image.asset(
                  'assets/edit_icon.png',
                  height: 25,
                )),
          )
        ],
        title: Text(
          'Профиль',
          textAlign: TextAlign.start,
          style: myTextStyle(16, MyColors.text, null),
        ),
        leading: IconButton(
          onPressed: () {
            ZoomDrawer.of(context)!.toggle();
          },
          icon: SvgPicture.asset('assets/Hamburger.svg'),
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
              SizedBox(
                height: 10,
              ),
              Text(
                name.text,
                textAlign: TextAlign.start,
                style: myTextStyle(20, MyColors.text, null),
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
                  child: GestureDetector(
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
                              'UUID: $uuid',
                              style: myTextStyle(
                                  16, Colors.black, TextDecoration.none),
                            ),
                          ),
                        ),
                      );
                    },
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
                              value: uuid),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
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
                isEditable: false,
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
                isEditable: false,
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
                isEditable: false,
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
                isEditable: false,
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
