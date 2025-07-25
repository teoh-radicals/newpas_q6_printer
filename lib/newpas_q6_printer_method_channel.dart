import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:newpas_q6_printer/column_maker.dart';
import 'package:newpas_q6_printer/enums.dart';

import 'newpas_q6_printer_platform_interface.dart';

/// An implementation of [NewpasQ6PrinterPlatform] that uses method channels.
class MethodChannelNewpasQ6Printer extends NewpasQ6PrinterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('newpas_q6_printer');

  @override
  Future<bool?> bindPrinter() async {
    final bool? status =
        await methodChannel.invokeMethod('BIND_PRINTER_SERVICE');
    return status;
  }

  @override
  Future<bool?> unbindPrinter() async {
    final bool? status =
        await methodChannel.invokeMethod('UNBIND_PRINTER_SERVICE');
    return status;
  }

  @override
  Future<bool?> initPrinter() async {
    final bool? status = await methodChannel.invokeMethod('INIT_PRINTER');
    return status;
  }

  @override
  Future<bool?> isReady() async {
    final bool? status = await methodChannel.invokeMethod('IS_PRINTER_READY');
    return status;
  }

  @override
  Future<void> printText(String text) async {
    Map<String, dynamic> arguments = <String, dynamic>{"text": '$text\n'};
    await methodChannel.invokeMethod("PRINT_TEXT", arguments);
  }

  @override
  Future<void> printRow(
      {required List<ColumnMaker> cols, bool end = true}) async {
    final jsonCols = List<Map<String, String>>.from(
        cols.map<Map<String, String>>((ColumnMaker col) => col.toJson()));
    Map<String, dynamic> arguments = <String, dynamic>{
      "cols": json.encode(jsonCols),
      "end": end ? 0 : 1
    };
    await methodChannel.invokeMethod("PRINT_ROW", arguments);
  }

  @override
  Future<void> printQRCode(String data,
      {int size = 5, QrcodeLevel errorLevel = QrcodeLevel.LEVEL_H}) async {
    int errorevel = 3;
    switch (errorLevel) {
      case QrcodeLevel.LEVEL_L:
        errorevel = 0;
        break;
      case QrcodeLevel.LEVEL_M:
        errorevel = 1;

        break;
      case QrcodeLevel.LEVEL_Q:
        errorevel = 2;
        break;
      case QrcodeLevel.LEVEL_H:
        errorevel = 3;
        break;
    }
    Map<String, dynamic> arguments = <String, dynamic>{
      "data": data,
      'modulesize': size,
      'errorlevel': errorevel
    };
    await methodChannel.invokeMethod("PRINT_QRCODE", arguments);
  }

  @override
  Future<void> printBarcode(String data,
      {BarcodeType barcodeType = BarcodeType.CODE128,
      int height = 162,
      int width = 2,
      BarcodeTextPos textPosition = BarcodeTextPos.TEXT_ABOVE}) async {
    int codeTypeValue = 8;
    int textPositionValue = 8;
    switch (barcodeType) {
      case BarcodeType.UPCA:
        codeTypeValue = 0;
        break;
      case BarcodeType.UPCE:
        codeTypeValue = 1;
        break;
      case BarcodeType.JAN13:
        codeTypeValue = 2;
        break;
      case BarcodeType.JAN8:
        codeTypeValue = 3;
        break;
      case BarcodeType.CODE39:
        codeTypeValue = 4;
        break;
      case BarcodeType.ITF:
        codeTypeValue = 5;
        break;
      case BarcodeType.CODABAR:
        codeTypeValue = 6;
        break;
      case BarcodeType.CODE93:
        codeTypeValue = 7;
        break;
      case BarcodeType.CODE128:
        codeTypeValue = 8;
        break;
    }

    switch (textPosition) {
      case BarcodeTextPos.NO_TEXT:
        textPositionValue = 0;
        break;
      case BarcodeTextPos.TEXT_ABOVE:
        textPositionValue = 1;
        break;
      case BarcodeTextPos.TEXT_UNDER:
        textPositionValue = 2;
        break;
      case BarcodeTextPos.BOTH:
        textPositionValue = 3;
        break;
    }
    Map<String, dynamic> arguments = <String, dynamic>{
      "data": data,
      'barcodeType': codeTypeValue,
      'textPosition': textPositionValue,
      'width': width,
      'height': height
    };
    await methodChannel.invokeMethod("PRINT_BARCODE", arguments);
  }

  @override
  Future<void> lineWrap(int lines, {int height = 1}) async {
    Map<String, dynamic> arguments = <String, dynamic>{"lines": lines, "height": height};
    await methodChannel.invokeMethod("LINE_WRAP", arguments);
  }

  @override
  Future<void> performPrint({int feeds = 0}) async {
    Map<String, dynamic> arguments = <String, dynamic>{"feeds": feeds};
    await methodChannel.invokeMethod("PERFORM_PRINT", arguments);
  }

  @override
  Future<void> setAlignment(PrintAlign alignment) async {
    late int value;
    switch (alignment) {
      case PrintAlign.LEFT:
        value = 0;
        break;
      case PrintAlign.CENTER:
        value = 1;
        break;
      case PrintAlign.RIGHT:
        value = 2;
        break;
      default:
        value = 0;
    }
    Map<String, dynamic> arguments = <String, dynamic>{"alignment": value};
    await methodChannel.invokeMethod("SET_ALIGNMENT", arguments);
  }

  @override
  Future<void> setFontSize(FontSize size) async {
    int fontSize = 24;
    switch (size) {
      case FontSize.SM:
        fontSize = 16;
        break;
      case FontSize.MD:
        fontSize = 24;
        break;
      case FontSize.LG:
        fontSize = 32;
        break;
      case FontSize.XL:
        fontSize = 48;
        break;
    }
    Map<String, dynamic> arguments = <String, dynamic>{"size": fontSize};

    await methodChannel.invokeMethod("FONT_SIZE", arguments);
  }

  // @override
  // Future<void> setBold() async {
  //   await methodChannel.invokeMethod("SET_BOLD");
  // }
  //
  // @override
  // Future<void> resetBold() async {
  //   await methodChannel.invokeMethod("RESET_BOLD");
  // }

  @override
  Future<void> printRawData(Uint8List data) async {
    Map<String, dynamic> arguments = <String, dynamic>{"data": data};
    await methodChannel.invokeMethod("RAW_DATA", arguments);
  }
}
