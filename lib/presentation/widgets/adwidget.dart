import 'dart:typed_data';
import 'package:champ/functions/func.dart';
import 'package:flutter/material.dart';

class AdWidget extends StatefulWidget {
  const AdWidget({super.key, required this.uuid});

  final String uuid;

  @override
  State<AdWidget> createState() => _AdWidgetState();
}

class _AdWidgetState extends State<AdWidget> {
  Future<Uint8List?>? _imageFuture;

  @override
  void initState() {
    super.initState();
    _imageFuture = Func().getAdImage(widget.uuid);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      height: MediaQuery.of(context).size.height - 820,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: FutureBuilder<Uint8List?>(
        future: _imageFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(
              child: Text('No image available'),
            );
          } else {
            return SizedBox(
              child: Image.memory(
                snapshot.data!,
                fit: BoxFit.contain,
              ),
            );
          }
        },
      ),
    );
  }
}
