import 'enums.dart';

///*ColumnMaker*
/// With this class you can build a column with some text and alignment
/// This is a good approach if you want to do a recepit like
/// With [text] , [width] and [align] you can build  a row as you like with any combination of alignment and size<br>
/// Name  Qtd Value
///
/// XXX   2   2.33
///
class ColumnMaker {
  String text;
  int width;
  PrintAlign align;
  ColumnMaker({
    this.text = '',
    this.width = 2,
    this.align = PrintAlign.LEFT,
  });
  //Convert to json
  Map<String, String> toJson() {
    int value = 0;
    switch (align) {
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
    return {
      "text": text,
      "width": width.toString(),
      "align": value.toString(),
    };
  }
}
