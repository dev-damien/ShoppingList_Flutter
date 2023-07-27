// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shoppinglist/01_presentation/add_friends/widgets/qr_code.dart';

class AddFriendsBody extends StatelessWidget {
  User user;

  AddFriendsBody({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: CupertinoSearchTextField(),
        ),
        QRCode(value: user.uid),
        CupertinoButton.filled(
          onPressed: () async {
            scanQR();
          },
          child: Text("open scanner"),
        ),
        //TODO add list displaying matching account(s)
      ],
    );
  }

  Future<void> scanQR() async {
    print('start  scanQR');
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      print('before await QR');
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
              '#ff6666', 'Cancel', true, ScanMode.QR)
          .whenComplete(() => print('completed'));
          //TODO do sth with qr code or return it
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    } on Exception {
      barcodeScanRes = "Unknown error occured";
    }
  }
}
