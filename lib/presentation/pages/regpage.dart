import 'package:champ/data/data.dart';
import 'package:champ/functions/func.dart';
import 'package:champ/presentation/colors/mycolors.dart';
import 'package:champ/presentation/textstyle.dart';
import 'package:champ/presentation/widgets/button.dart';
import 'package:champ/presentation/widgets/textbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegPage extends StatefulWidget {
  const RegPage({super.key});

  @override
  State<RegPage> createState() => _RegPageState();
}

bool isChecked = false;
TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
TextEditingController name = TextEditingController();

class _RegPageState extends State<RegPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.block,
      appBar: AppBar(
        backgroundColor: MyColors.block,
        leading: Container(
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: MyColors.background,
              borderRadius: BorderRadius.circular(30)),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Регистрация',
                style: myTextStyle(32, MyColors.text, null),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 100,
                child: Text(
                  textAlign: TextAlign.center,
                  'Заполните Свои данные или продолжите через социальные медиа',
                  style: myTextStyle(16, MyColors.subtextdark, null),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 50,
                      child: Text(
                        textAlign: TextAlign.start,
                        'Ваше имя',
                        style: myTextStyle(16, MyColors.text, null),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 50,
                      child: TextBox(
                        onSubmit: null,
                        controller: name,
                        email: true,
                        hint: 'xxxxxxxx',
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 50,
                      child: Text(
                        textAlign: TextAlign.start,
                        'Email',
                        style: myTextStyle(16, MyColors.text, null),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 50,
                      child: TextBox(
                        onSubmit: null,
                        controller: email,
                        email: true,
                        hint: 'xyz@gmail.com',
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 50,
                      child: Text(
                        textAlign: TextAlign.start,
                        'Пароль',
                        style: myTextStyle(16, MyColors.text, null),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 50,
                      child: TextBox(
                        onSubmit: null,
                        controller: password,
                        email: false,
                        hint: '*********',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 60,
                      child: Row(
                        children: [
                          Checkbox(
                            shape: const CircleBorder(),
                            value: isChecked,
                            onChanged: (asd) {
                              setState(() {
                                isChecked = !isChecked;
                                Data.isChecked = isChecked;
                              });
                            },
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 150,
                            child: GestureDetector(
                              onTap: () {
                                Func().launchPdf(context);
                              },
                              child: Text(
                                textAlign: TextAlign.start,
                                'Даю согласие на обработку персональных данных',
                                style: myTextStyle(16, MyColors.text,
                                    TextDecoration.underline),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Button(
                      onTap: () => Func().tryToRegUser(
                          email.text, password.text, name.text, context),
                      title: 'Зарегистрироваться',
                      controller: null,
                      bgcolor: MyColors.accent,
                      titlecolor: Colors.white,
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(bottom: 50),
                height: MediaQuery.of(context).size.height - 750,
                width: MediaQuery.of(context).size.width - 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        textAlign: TextAlign.center,
                        'Есть аккаунт?',
                        style: myTextStyle(16, MyColors.subtextdark, null)),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                          textAlign: TextAlign.center,
                          'Войти',
                          style: myTextStyle(16, MyColors.text, null)),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
