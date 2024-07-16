

package com.iposprinter.iposprinterservice;
import  com.iposprinter.iposprinterservice.IPosPrinterCallback;
import  android.graphics.Bitmap;

interface IPosPrinterService {

    int getPrinterStatus();

    void printerInit(in IPosPrinterCallback callback);


    void setPrinterPrintDepth(int depth,in IPosPrinterCallback callback);


    void setPrinterPrintFontType(String typeface,in IPosPrinterCallback callback);

    /**
    * 打印指定字体类型和大小文本，字体设置只对本次有效
    * 文字宽度满一行自动换行排版
    * @param text:	要打印的文字字符串
    * @param typeface:  字体名称 ST（目前只支持一种）
    * @param fontsize:	字体大小，目前支持的size有16、24、32、48，输入非法size执行默认值24
    * @param callback  执行结果回调
    * @return
    */
    void setPrinterPrintFontSize(int fontsize,in IPosPrinterCallback callback);

    void setPrinterPrintAlignment(int alignment, in IPosPrinterCallback callback);


    void printerFeedLines(int lines,in IPosPrinterCallback callback);

    void printBlankLines(int lines,int height,in IPosPrinterCallback callback);


    void printText(String text, in IPosPrinterCallback callback);


    void printSpecifiedTypeText(String text, String typeface,int fontsize,in IPosPrinterCallback callback);


    void PrintSpecFormatText(String text, String typeface, int fontsize, int alignment, IPosPrinterCallback callback);

    /**
	* 打印表格的一行，可以指定列宽、对齐方式
	* @param colsTextArr   各列文本字符串数组
	* @param colsWidthArr  各列宽度数组  总宽度不能大于((384 / fontsize) << 1)-（列数+1）
	*                      (以英文字符计算, 每个中文字符占两个英文字符, 每个宽度大于0),
	* @param colsAlign	        各列对齐方式(0居左, 1居中, 2居右)
	* @param isContinuousPrint   是否继续续打印表格 1：继续续打印  0：不继续打印
	* 备注: 三个参数的数组长度应该一致, 如果colsTextArr[i]的宽度大于colsWidthArr[i], 则文本换行
	* @param callback  执行结果回调
	* @return
	*/
	void printColumnsText(in String[] colsTextArr, in int[] colsWidthArr, in int[] colsAlign,int isContinuousPrint, in IPosPrinterCallback callback);


    void printBitmap(int alignment, int bitmapSize, in Bitmap mBitmap, in IPosPrinterCallback callback);

    /**
	* 打印一维条码
	* @param data: 		条码数据
	* @param symbology: 	条码类型
	*    0 -- UPC-A，
	*    1 -- UPC-E，
	*    2 -- JAN13(EAN13)，
	*    3 -- JAN8(EAN8)，
	*    4 -- CODE39，
	*    5 -- ITF，
	*    6 -- CODABAR，
	*    7 -- CODE93，
	*    8 -- CODE128
	* @param height: 		条码高度, 取值1到16, 超出范围默认取6，每个单位代表24个像素点高度
	* @param width: 		条码宽度, 取值1至16, 超出范围默认取12，每个单位代表24个像素点长度
	* @param textposition:	文字位置 0--不打印文字, 1--文字在条码上方, 2--文字在条码下方, 3--条码上下方均打印
	* @param callback  执行结果回调
	* @return
	*/
	void printBarCode(String data, int symbology, int height, int width, int textposition,  in IPosPrinterCallback callback);

    /**
	* 打印二维条码
	* @param data:			二维码数据
	* @param modulesize:	二维码块大小(单位:点, 取值 1 至 16 ),超出设置范围默认取值10
	* @param mErrorCorrectionLevel : 二维纠错等级(0:L 1:M 2:Q 3:H)
	* @param callback  执行结果回调
	* @return
	*/
	void printQRCode(String data, int modulesize, int mErrorCorrectionLevel, in IPosPrinterCallback callback);


	void printRawData(in byte[] rawPrintData, in IPosPrinterCallback callback);


	void sendUserCMDData(in byte[] data, in IPosPrinterCallback callback);


	void printerPerformPrint(int feedlines, in IPosPrinterCallback callback);
}
