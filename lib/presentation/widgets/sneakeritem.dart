import 'package:champ/presentation/colors/mycolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SneakerItem extends StatefulWidget {
  const SneakerItem({
    super.key,
    required this.name,
    required this.price,
  });

  final String name;
  final double price;

  @override
  State<SneakerItem> createState() => _SneakerItemState();
}

class _SneakerItemState extends State<SneakerItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 20),
      child: Container(
        alignment: Alignment.centerLeft,
        width: 160,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset('assets/heart.svg'),
                ),
              ],
            ),
            Image.asset(
              fit: BoxFit.cover,
              'assets/sneaker.png',
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'BEST SELLER',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        color: MyColors.lighterBlue,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    widget.name,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 10),
                  child: Text(
                    '₽ ${widget.price}',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: MyColors.lighterBlue,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                  ),
                  child: SvgPicture.asset('assets/plus.svg'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
