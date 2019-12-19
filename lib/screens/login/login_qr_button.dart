import 'package:animu_common/animu_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class LoginQRButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GradientButton(
      callback: () async {
        final dynamic result = await Navigator.push(
            context, MaterialPageRoute(builder: (context) => QRLoginView()));

        Future.delayed(Duration.zero, () {
          if (result != null) {
            BlocProvider.of<LoginBloc>(context).add(
              LoginButtonPressed(token: result),
            );
          }
        });
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

class QRLoginView extends StatefulWidget {
  @override
  _QRLoginViewState createState() => _QRLoginViewState();
}

class _QRLoginViewState extends State<QRLoginView> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QRView(
        key: qrKey,
        onQRViewCreated: (QRViewController controller) {
          this.controller = controller;
          controller.scannedDataStream.listen((scanData) {
            Navigator.pop(context, scanData);
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
