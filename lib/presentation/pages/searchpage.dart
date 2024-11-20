import 'dart:developer';

import 'package:champ/functions/func.dart';
import 'package:champ/presentation/widgets/searchhistorymanager.dart';
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
        forceMaterialTransparency: true,
        title: Text(
          'Поиск',
          textAlign: TextAlign.start,
          style: GoogleFonts.raleway(
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: Container(
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30)),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new_outlined),
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
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 50,
                child: ListView.builder(
                  itemCount: history.length,
                  itemBuilder: (context, index) => history[index].isEmpty
                      ? SizedBox()
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20)),
                            child: ListTile(
                              onTap: () {
                                setState(() {
                                  history.removeAt(index);
                                });
                              },
                              title: Text(
                                history[index],
                              ),
                            ),
                          ),
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
