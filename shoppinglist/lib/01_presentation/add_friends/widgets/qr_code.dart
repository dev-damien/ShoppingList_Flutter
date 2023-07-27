// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCode extends StatelessWidget {
  final String value;

  const QRCode({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QrImageView(
      data: value,
      version: QrVersions.auto,
      size: 320,
      gapless: false,
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
      eyeStyle: QrEyeStyle(
          eyeShape: QrEyeShape.square, color: CupertinoColors.activeBlue),
    );
  }
}
