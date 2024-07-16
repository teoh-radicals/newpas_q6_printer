import 'dart:typed_data';

import 'package:newpas_q6_printer/column_maker.dart';
import 'package:newpas_q6_printer/enums.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'newpas_q6_printer_method_channel.dart';

abstract class NewpasQ6PrinterPlatform extends PlatformInterface {
  /// Constructs a NewpasQ6PrinterPlatform.
  NewpasQ6PrinterPlatform() : super(token: _token);

  static final Object _token = Object();

  static NewpasQ6PrinterPlatform _instance = MethodChannelNewpasQ6Printer();

  /// The default instance of [NewpasQ6PrinterPlatform] to use.
  ///
  /// Defaults to [MethodChannelNewpasQ6Printer].
  static NewpasQ6PrinterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NewpasQ6PrinterPlatform] when
  /// they register themselves.
  static set instance(NewpasQ6PrinterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool?> bindPrinter() {
    throw UnimplementedError('bindPrinter() has not been implemented.');
  }

  Future<bool?> unbindPrinter() {
    throw UnimplementedError('unbindPrinter() has not been implemented.');
  }

  Future<bool?> initPrinter() {
    throw UnimplementedError('initPrinter() has not been implemented.');
  }

  Future<void> printText(String text) {
    throw UnimplementedError('printText() has not been implemented.');
  }

  Future<void> performPrint({int feeds = 0}) {
    throw UnimplementedError('performPrint() has not been implemented.');
  }

  Future<void> setAlignment(PrintAlign alignment) {
    throw UnimplementedError('setAlignment() has not been implemented.');
  }

  Future<void> setFontSize(FontSize size) {
    throw UnimplementedError('setFontSize() has not been implemented.');
  }

  Future<void> printRow({required List<ColumnMaker> cols, bool end = false}) {
    throw UnimplementedError('printRow() has not been implemented.');
  }

  Future<void> printQRCode(String data,
      {int size = 5, QrcodeLevel errorLevel = QrcodeLevel.LEVEL_H}) {
    throw UnimplementedError('printQRCode() has not been implemented.');
  }

  Future<void> printBarcode(String data,
      {BarcodeType barcodeType = BarcodeType.CODE128,
      int height = 162,
      int width = 2,
      BarcodeTextPos textPosition = BarcodeTextPos.TEXT_UNDER}) {
    throw UnimplementedError('setFontSize() has not been implemented.');
  }

  Future<void> lineWrap(int lines, {int height = 1}) {
    throw UnimplementedError('setFontSize() has not been implemented.');
  }

  // Future<void> setBold() {
  //   throw UnimplementedError('bold() has not been implemented.');
  // }
  //
  // Future<void> resetBold() {
  //   throw UnimplementedError('resetBold() has not been implemented.');
  // }

  Future<void> printRawData(Uint8List data) {
    throw UnimplementedError('printRawData() has not been implemented.');
  }


}
