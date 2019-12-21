import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

class LoginQRButton extends StatelessWidget {
  final showQRView;
  LoginQRButton({@required this.showQRView});

  @override
  Widget build(BuildContext context) {
    return GradientButton(
      callback: () async {
        showQRView();
      },
      increaseWidthBy: 50.0,
      shadowColor: Gradients.backToFuture.colors.last.withOpacity(0.25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(FontAwesomeIcons.qrcode),
          SizedBox(
            width: 5.0,
          ),
          Text('Scan QR Code'),
        ],
      ),
    );
  }
}
