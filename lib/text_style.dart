import 'enums.dart';

///*TextStyle*
///
///With this class you can build your own layout to print some text.
///The text can come already with [align], [fontSize] and *bold*, and then you don't need to type 3 commands to do the same THING!

class PrinterTextStyle {
  FontSize? fontSize;
  PrintAlign? align;
  // bool? bold;

  PrinterTextStyle({this.fontSize, this.align});
}
