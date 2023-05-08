import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:paye_ton_kawa/services/secure_storage.dart';
import 'package:paye_ton_kawa/styles/custom_colors.dart';
import 'package:paye_ton_kawa/views/products_list.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../widgets/custom_app_bar.dart';

class ScannerAuthentication extends StatefulWidget {
  const ScannerAuthentication({super.key});

  @override
  State<ScannerAuthentication> createState() => _ScannerAuthenticationState();
}

class _ScannerAuthenticationState extends State<ScannerAuthentication> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final SecureStorage _secureStorage = SecureStorage();

  @override
  void reassemble() {
    super.reassemble();
    if(Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        isAuthent: false,
      ),
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding:  const EdgeInsets.all(16),
                    child:
                      (result != null) 
                      ? const Text(
                          'Authentification réussie !',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      : const Text(
                          'Scannez votre QR Code d\'authentification',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 350.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: CustomColors.darkGold,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      setState(() {});
      result = scanData;
      controller.pauseCamera();

      if (result?.format == BarcodeFormat.qrcode) {
        log(result!.code.toString());
        try {
          await _secureStorage.setToken(result!.code!);
          Future.delayed(const Duration(milliseconds: 500), () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ProductsList()));
          });
        }
        on FormatException {
          Fluttertoast.showToast(
            msg: 'QR Code invalide !',
            textColor: Colors.red,
          );
          controller.resumeCamera();
        }
        on Exception {
          Fluttertoast.showToast(
            msg: 'Une erreur est survenue, veuillez réessayer.',
            textColor: Colors.red,
          );
          controller.resumeCamera();
        }
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permission refusée !')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}