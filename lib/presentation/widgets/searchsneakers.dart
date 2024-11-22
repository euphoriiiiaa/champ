import 'package:champ/functions/func.dart';
import 'package:champ/models/sneakermodel.dart';
import 'package:champ/presentation/widgets/sneakeritem.dart';
import 'package:flutter/material.dart';

class SearchSneakers extends StatefulWidget {
  const SearchSneakers({super.key, required this.searchText});

  final String searchText;

  @override
  State<SearchSneakers> createState() => _SearchSneakersState();
}

class _SearchSneakersState extends State<SearchSneakers> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(top: 30),
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 50,
          child: FutureBuilder(
              future: Func().getSneakers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No sneakers found.'));
                } else {
                  List<SneakerModel> sneakers = snapshot.data!;
                  var sortSneakers = sneakers
                      .where((sneaker) => sneaker.name
                          .toLowerCase()
                          .contains(widget.searchText.toLowerCase()))
                      .toList();
                  sortSneakers.sort((a, b) =>
                      a.name.toLowerCase().compareTo(b.name.toLowerCase()));
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.8,
                      crossAxisCount: 2,
                    ),
                    scrollDirection: Axis.vertical,
                    itemCount: sortSneakers.length,
                    itemBuilder: (context, index) {
                      return SneakerItem(
                        category: null,
                        description: null,
                        bestseller: null,
                        fullname: null,
                        height: 50,
                        width: 200,
                        name: sortSneakers[index].name,
                        price: sortSneakers[index].price,
                        id: sortSneakers[index].id,
                      );
                    },
                  );
                }
              }),
        ),
      ),
    );
  }
}
