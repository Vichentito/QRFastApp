import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class QrScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: Icon(Icons.filter_center_focus),
      onPressed: () async{ 
        // FlutterBarcodeScanner.getBarcodeStreamReceiver("#bd5757", "Cancelar", false, ScanMode.QR)
        //  .listen((barcode) { 
        //  print(barcode);
        //  });
        // String scanResponse = await FlutterBarcodeScanner.scanBarcode(
        //   '#bd5757',
        //   'Cancelar',
        //   false,
        //   ScanMode.BARCODE
        //   );
        final scanResponse = 'id:258';
        print(scanResponse);
        
       },
    );
  }
}