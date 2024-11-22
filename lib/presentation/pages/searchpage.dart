import 'dart:developer';

import 'package:champ/functions/func.dart';
import 'package:champ/models/sneakermodel.dart';
import 'package:champ/presentation/colors/mycolors.dart';
import 'package:champ/presentation/textstyle.dart';
import 'package:champ/presentation/widgets/arrowicon.dart';
import 'package:champ/presentation/widgets/searchhistorymanager.dart';
import 'package:champ/presentation/widgets/searchsneakers.dart';
import 'package:champ/presentation/widgets/sneakeritem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({super.key});

  @override
  State<Searchpage> createState() => _SearchpageState();
}

TextEditingController searchController = TextEditingController();
List<String> history = [];

class _SearchpageState extends State<Searchpage> {
  @override
  void initState() {
    loadHistory();
    super.initState();
  }

  Future<void> loadHistory() async {
    history = await Func().loadHistoryList();
    if (history.isEmpty) {
      log('list is empty');
    } else {
      log('list isnt empty');
    }
    setState(() {});
  }

  @override
  void dispose() {
    Func().saveHistoryList(history);
    history.clear();
    searchController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff7f7f9),
      appBar: AppBar(
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Text('Поиск',
            textAlign: TextAlign.start,
            style: myTextStyle(16, MyColors.text, null)),
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextField(
              onSubmitted: (value) {
                setState(() {
                  history.add(value);
                  searchController.clear();
                });
              },
              onChanged: (value) {
                setState(() {
                  searchController.text = value;
                  log(searchController.text);
                });
              },
              controller: searchController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 20),
                hintStyle: TextStyle(color: Colors.grey[400]),
                hintText: 'Поиск',
                prefixIcon: Icon(Icons.search),
                suffixIcon: SizedBox(
                  width: 10,
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/divider.svg'),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.mic),
                    ],
                  ),
                ),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none),
              ),
            ),
            searchController.text.isEmpty
                ? Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 50,
                        child: ListView.builder(
                          itemCount: history.length,
                          itemBuilder: (context, index) => history[index]
                                  .isEmpty
                              ? const SizedBox()
                              : GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      history.removeAt(index);
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                                'assets/time_icon.svg'),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              history[index],
                                              textAlign: TextAlign.start,
                                              style: GoogleFonts.raleway(
                                                textStyle: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  )
                : SearchSneakers(
                    searchText: searchController.text,
                  )
          ],
        ),
      ),
    );
  }
}
