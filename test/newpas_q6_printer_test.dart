import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:newpas_q6_printer/column_maker.dart';
import 'package:newpas_q6_printer/enums.dart';
import 'package:newpas_q6_printer/newpas_q6_printer.dart';
import 'package:newpas_q6_printer/newpas_q6_printer_platform_interface.dart';
import 'package:newpas_q6_printer/newpas_q6_printer_method_channel.dart';
import 'package:newpas_q6_printer/text_style.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockNewpasQ6PrinterPlatform
    with MockPlatformInterfaceMixin
    implements NewpasQ6PrinterPlatform {
  @override
  Future<bool?> initPrinter() => Future.value(true);

  @override
  Future<bool?> unbindPrinter() => Future.value(true);

  @override
  Future<bool?> bindPrinter() => Future.value(true);

  @override
  Future<void> printText(String text, {PrinterTextStyle? style}) =>
      Future.value(null);

  @override
  Future<void> performPrint({int feeds = 0}) => Future.value(null);

  @override
  Future<void> setAlignment(PrintAlign alignment) => Future.value(null);

  @override
  Future<void> setFontSize(FontSize size) => Future.value(null);

  @override
  Future<void> printRow({required List<ColumnMaker> cols, bool end = false}) =>
      Future.value(null);

  @override
  Future<void> printQRCode(String data,
          {int size = 5, QrcodeLevel errorLevel = QrcodeLevel.LEVEL_H}) =>
      Future.value(null);

  @override
  Future<void> printBarcode(String data,
          {BarcodeType barcodeType = BarcodeType.CODE128,
          int height = 162,
          int width = 2,
          BarcodeTextPos textPosition = BarcodeTextPos.TEXT_UNDER}) =>
      Future.value(null);

  @override
  Future<void> lineWrap(int lines, {int height = 1}) => Future.value(null);

  @override
  Future<void> printRawData(Uint8List data) => Future.value(null);
}

void main() {
  final NewpasQ6PrinterPlatform initialPlatform =
      NewpasQ6PrinterPlatform.instance;

  test('$MethodChannelNewpasQ6Printer is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelNewpasQ6Printer>());
  });

  test('initPrinter', () async {
    NewpasQ6Printer newpasQ6PrinterPlugin = NewpasQ6Printer();
    MockNewpasQ6PrinterPlatform fakePlatform = MockNewpasQ6PrinterPlatform();
    NewpasQ6PrinterPlatform.instance = fakePlatform;

    expect(await newpasQ6PrinterPlugin.initPrinter(), Future.value(true));
  });
}
