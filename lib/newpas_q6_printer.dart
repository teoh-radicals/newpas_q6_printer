import 'package:newpas_q6_printer/column_maker.dart';
import 'package:newpas_q6_printer/enums.dart';

import 'newpas_q6_printer_platform_interface.dart';
import 'package:newpas_q6_printer/text_style.dart';

class NewpasQ6Printer {
  Future<bool?> bindPrinter() {
    return NewpasQ6PrinterPlatform.instance.bindPrinter();
  }

  Future<bool?> unbindPrinter() {
    return NewpasQ6PrinterPlatform.instance.unbindPrinter();
  }

  Future<bool?> initPrinter() {
    return NewpasQ6PrinterPlatform.instance.initPrinter();
  }

  Future<void> printText(String text, {PrinterTextStyle? style}) async {
    if (style != null) {
      if (style.align != null) {
        await setAlignment(style.align!);
      }

      if (style.fontSize != null) {
        await setFontSize(style.fontSize!);
      }

      // if (style.bold != null) {
      //   if (style.bold == true) {
      //     await bold();
      //   }else{
      //     await resetBold();
      //   }
      // }
    }
    return NewpasQ6PrinterPlatform.instance.printText(text);
  }

  Future<void> performPrint({int feed = 0}) async {
    return NewpasQ6PrinterPlatform.instance.performPrint(feeds: feed);
  }

  // Future<void> bold() {
  //   return NewpasQ6PrinterPlatform.instance.setBold();
  // }
  //
  // Future<void> resetBold() {
  //   return NewpasQ6PrinterPlatform.instance.resetBold();
  // }

  Future<void> printRow(List<ColumnMaker> columns, {bool end = false}) {
    return NewpasQ6PrinterPlatform.instance.printRow(cols: columns, end: end);
  }

  Future<void> printQRCode(String data,
      {int size = 5, QrcodeLevel errorLevel = QrcodeLevel.LEVEL_H}) {
    return NewpasQ6PrinterPlatform.instance
        .printQRCode(data, size: size, errorLevel: errorLevel);
  }

  Future<void> printBarcode(String data,
      {BarcodeType barcodeType = BarcodeType.CODE128,
      int height = 162,
      int width = 2,
      BarcodeTextPos textPosition = BarcodeTextPos.TEXT_UNDER}) {
    return NewpasQ6PrinterPlatform.instance.printBarcode(data,
        barcodeType: barcodeType,
        height: height,
        width: width,
        textPosition: textPosition);
  }

  Future<void> lineWrap(int lines, {int height = 1}) {
    return NewpasQ6PrinterPlatform.instance.lineWrap(lines, height: height);
  }

  Future<void> line({
    String ch = '-',
    int len = 31,
  }) async {
    await resetFontSize();
    await printText(List.filled(len, ch[0]).join());
  }

  Future<void> setAlignment(PrintAlign alignment) {
    return NewpasQ6PrinterPlatform.instance.setAlignment(alignment);
  }

  Future<void> setFontSize(FontSize size) {
    return NewpasQ6PrinterPlatform.instance.setFontSize(size);
  }

  Future<void> resetFontSize() async {
    await setFontSize(FontSize.MD);
  }

// static Future<bool?> bindingPrinter() async {
//   final bool? status = await _channel.invokeMethod('BIND_PRINTER_SERVICE');
//   return status;
// }
}
