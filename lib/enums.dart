// ignore_for_file: constant_identifier_names
library enums;

///*PrinterStatus*
///
///This enum will give you the status of the printer.
///Sometimes the status can be ERROR, but don't worry about this status, always try co print anyway!
enum PrinterStatus {
  UNKNOWN,
  ERROR,
  NORMAL,
  ABNORMAL_COMMUNICATION,
  OUT_OF_PAPER,
  PREPARING,
  OVERHEATED,
  OPEN_THE_LID,
  PAPER_CUTTER_ABNORMAL,
  PAPER_CUTTER_RECOVERED,
  NO_BLACK_MARK,
  NO_PRINTER_DETECTED,
  FAILED_TO_UPGRADE_FIRMWARE,
  EXCEPTION,
}

///*PrinterMode*
///
///Enum to set printer mode
enum PrinterMode {
  UNKNOWN,
  NORMAL_MODE,
  BLACK_LABEL_MODE,
  LABEL_MODE,
}

///*PrintAlign*
///
///Enum to set printer aligntment
enum PrintAlign {
  LEFT,
  CENTER,
  RIGHT,
}

///*QrcodeLevel*
///
/// Enum to set a QRcode Level (Low to High)
/// 0 - L
/// 1 - M
/// 2 - Q
/// 3 - H
enum QrcodeLevel {
  LEVEL_L,
  LEVEL_M,
  LEVEL_Q,
  LEVEL_H,
}

///*BarcodeType*
///
///Enum to set Barcode Type
///*     0 -- UPC-A，
/// *    1 -- UPC-E，
/// *    2 -- JAN13(EAN13)，
/// *    3 -- JAN8(EAN8)，
/// *    4 -- CODE39，
/// *    5 -- ITF，
/// *    6 -- CODABAR，
/// *    7 -- CODE93，
/// *    8 -- CODE128
enum BarcodeType {
  UPCA,
  UPCE,
  JAN13,
  JAN8,
  CODE39,
  ITF,
  CODABAR,
  CODE93,
  CODE128,
}

///*BarcodeTextPos*
///
///Enum to set how the they will be printed in barcode
///0--NO_TEXT,
///1--TEXT_ABOVE
///2--TEXT_UNDER
///3--BOTH
enum BarcodeTextPos {
  NO_TEXT,
  TEXT_ABOVE,
  TEXT_UNDER,
  BOTH,
}

///*FontSize*
///Enum to set font in the printer
enum FontSize {
  SM,
  MD,
  LG,
  XL,
}
