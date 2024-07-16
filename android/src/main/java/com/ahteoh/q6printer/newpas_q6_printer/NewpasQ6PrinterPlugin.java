package com.ahteoh.q6printer.newpas_q6_printer;

import androidx.annotation.NonNull;

import io.flutter.Log;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import android.content.Context;

import android.widget.Toast;

import org.json.JSONArray;
import org.json.JSONObject;


/**
 * NewpasQ6PrinterPlugin
 */
public class NewpasQ6PrinterPlugin implements FlutterPlugin, MethodCallHandler {
    private static Q6PrinterMethod q6PrinterMethod;
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "newpas_q6_printer");
        q6PrinterMethod = new Q6PrinterMethod(flutterPluginBinding.getApplicationContext());
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        switch (call.method) {
            case "BIND_PRINTER_SERVICE":
                q6PrinterMethod.bindPrinterService();
                result.success(true);
                break;
            case "UNBIND_PRINTER_SERVICE":
                q6PrinterMethod.unbindPrinterService();
                result.success(true);
                break;
            case "INIT_PRINTER":
                q6PrinterMethod.initPrinter();
                result.success(true);
                break;
            case "PRINT_TEXT":
                String text = call.argument("text");
                q6PrinterMethod.printText(text);
                result.success(true);
                break;
            case "FONT_SIZE":
                int fontSize = call.argument("size");
                q6PrinterMethod.setFontSize(fontSize);
                result.success(true);
                break;
            case "SET_ALIGNMENT":
                int alignment = call.argument("alignment");
                q6PrinterMethod.setAlignment(alignment);
                result.success(true);
                break;
            case "SET_BOLD":
                // not support in Q6 device
                q6PrinterMethod.setFontBold(true);
                result.success(true);
                break;
            case "RESET_BOLD":
                // not support in Q6 device
                q6PrinterMethod.setFontBold(false);
                result.success(true);
                break;
            case "PRINT_ROW":
                String colsStr = call.argument("cols");
                int end = call.argument("end");
                try {
                    JSONArray cols = new JSONArray(colsStr);
                    String[] colsText = new String[cols.length()];
                    int[] colsWidth = new int[cols.length()];
                    int[] colsAlign = new int[cols.length()];
                    for (int i = 0; i < cols.length(); i++) {
                        JSONObject col = cols.getJSONObject(i);
                        String textColumn = col.getString("text");
                        int widthColumn = col.getInt("width");
                        int alignColumn = col.getInt("align");
                        colsText[i] = textColumn;
                        colsWidth[i] = widthColumn;
                        colsAlign[i] = alignColumn;
                    }

                    q6PrinterMethod.printColumn(colsText, colsWidth, colsAlign, end);
                    result.success(true);
                } catch (Exception err) {
                    Log.d("SunmiPrinter", err.getMessage());
                }
                break;
            case "PRINT_QRCODE":
                String data = call.argument("data");
                int modulesize = call.argument("modulesize");
                int errorlevel = call.argument("errorlevel");
                q6PrinterMethod.printQRCode(data, modulesize, errorlevel);
                result.success(true);
                break;
            case "PRINT_BARCODE":
                String barCodeData = call.argument("data");
                int barcodeType = call.argument("barcodeType");
                int textPosition = call.argument("textPosition");
                int width = call.argument("width");
                int height = call.argument("height");
                q6PrinterMethod.printBarCode(barCodeData, barcodeType, textPosition, width, height);
                q6PrinterMethod.lineWrap(1, 1);

                result.success(true);
                break;

            case "LINE_WRAP":
                int lines = call.argument("lines");
                int lineHeight = call.argument("height");
                q6PrinterMethod.lineWrap(lines, lineHeight);
                result.success(true);
                break;
            case "RAW_DATA":
                q6PrinterMethod.sendRaw((byte[]) call.argument("data"));
                result.success(true);
                break;
            case "PERFORM_PRINT":
                int feeds = call.argument("feeds");
                q6PrinterMethod.performPrint(feeds);
                result.success(true);
                break;
            default:
                result.notImplemented();
                break;

        }

    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }
}
